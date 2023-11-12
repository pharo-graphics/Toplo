"
A ToSkinStateGeneratorTest is a test class for testing the behavior of ToSkinStateGenerator
"
Class {
	#name : #ToSkinStateGeneratorTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Theme'
}

{ #category : #'instance creation' }
ToSkinStateGeneratorTest >> newElementInSpace [

	| e |
	e := ToElement new.
	self assert: e skinInstaller isNil.
	space root addChild: e.
	self assert: e skinInstaller notNil.
	" to install the element skin  "
	space applyAllSkinInstallers.

	^ e
]

{ #category : #running }
ToSkinStateGeneratorTest >> setUp [ 
	super setUp.
	space := self newTestingSpace
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testCheckableCheckedEvent [

	self testGenerateCheckStateFromEvent 
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testGenerateCheckStateFromEvent [

	| e evt nextStates currentStates nextStatesSize currentStatesSize |
	e := self newElementInSpace.
		
	nextStates := e skinStateQueue nextStates.
	currentStates := e skinStateQueue currentStates.
	
	nextStatesSize := nextStates size.
	currentStatesSize := currentStates size.

	evt := ToCheckableCheckedEvent new
		       current: false;
		       previous: true;
		       yourself.

	self assert: nextStates size equals: nextStatesSize.
	self assert: currentStates size equals: currentStatesSize.

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToUncheckedState ]) size
		equals: 1.
	self assert: nextStates size equals: nextStatesSize + 1.
	self
		assert:
		(currentStates select: [ :s | s isKindOf: ToUncheckedState ]) size
		equals: 1.
	self assert: currentStates size equals: currentStatesSize + 1.

	nextStatesSize := nextStates size.
	currentStatesSize := currentStates size.

	evt := ToCheckableCheckedEvent new
		       current: false;
		       previous: true;
		       yourself.
	e dispatchEvent: evt.
	
	" no changed since the element is in the same state (2 successives uncheck) "
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToUncheckedState ]) size
		equals: 1.
	self assert: nextStates size equals: nextStatesSize.
	self
		assert:
		(currentStates select: [ :s | s isKindOf: ToUncheckedState ]) size
		equals: 1.
	self assert: currentStates size equals: currentStatesSize.
	
	evt := ToCheckableCheckedEvent new
		       current: true;
		       previous: false;
		       yourself.
	e dispatchEvent: evt.
	
	" now the state is changed "
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToUncheckedState ]) size
		equals: 0.
	self
		assert:
		(currentStates select: [ :s | s isKindOf: ToUncheckedState ]) size
		equals: 0.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToCheckedState ]) size
		equals: 1.
	self
		assert:
		(currentStates select: [ :s | s isKindOf: ToCheckedState ]) size
		equals: 1
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testGenerateClickedStateFromEvent [

	| e evt nextStates currentStates |
	e := self newElementInSpace.

	evt := BlMouseButton primary clickEventClass new button: BlMouseButton primary.

	nextStates := e skinStateQueue nextStates.
	currentStates := e skinStateQueue currentStates.

	self assert: nextStates size equals: 3.
	self assert: (nextStates last isKindOf: ToInstallState).
	self assert: currentStates size equals: 1.
	self assert: (currentStates last isKindOf: ToEnabledState).

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToClickedState ]) size
		equals: 1.
	self assert: nextStates size equals: 4.

	self assert: currentStates size equals: 1.

	evt := BlMouseButton primary clickEventClass new button:
		       BlMouseButton primary.

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToClickedState ]) size
		equals: 1.
	self assert: nextStates size equals: 4
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testGenerateHoveredStateFromEvent [

	| e evt nextStates currentStates |
	e := self newElementInSpace.

	evt := BlMouseEnterEvent new.

	nextStates := e skinStateQueue nextStates.
	currentStates := e skinStateQueue currentStates.

	self assert: nextStates size equals: 3.
	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToHoveredState ]) size
		equals: 1.
	self assert: nextStates size equals: 4.

	evt := BlMouseEnterEvent new.

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToHoveredState ]) size
		equals: 1.
	self assert: nextStates size equals: 4.

	evt := BlMouseLeaveEvent new.

	e dispatchEvent: evt.

	self
		assert: (nextStates select: [ :s | s isKindOf: ToLeavedState ]) size
		equals: 1.
	" ToEnabledState remains and ToLeavedState isNot persistent, ToHoveredState should have been removed "
	self assert: nextStates size equals: 4
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testOnInstalledIn [

	| e h |
	e := ToElement new.
	h := ToSkinStateGenerator new.
	self should: [e addEventHandler: h] raise: Error.

]

{ #category : #tests }
ToSkinStateGeneratorTest >> testOnUninstalledIn [

	self testOnInstalledIn
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testTarget [

	| e gen |
	e := ToElement new.
	gen := e eventDispatcher handlers detect: [ :h |
		       h isKindOf: e skinStateGeneratorClass ].
	self assert: gen target identicalTo: e
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testWantsEvent [

	| e gen eventsToHandle eventsToHandleWhenDisabled |
	e := ToElement new.
	self assert: e isEnabled.
	gen := e eventDispatcher handlers detect: [ :h |
		       h isKindOf: e skinStateGeneratorClass ].
	eventsToHandle := gen eventsToHandle.
	eventsToHandle do: [ :cC |
		self assert: (gen wantsEvent: (cC new currentTarget: e)) ].
	e disable.
	self deny: e isEnabled.
	eventsToHandleWhenDisabled := gen eventsToHandleWhenDisabled.
	eventsToHandleWhenDisabled do: [ :cC | self assert: (gen wantsEvent: (cC new currentTarget: e)) ].
	eventsToHandle do: [ :cC | 
		(eventsToHandleWhenDisabled anySatisfy: [:dC | cC == dC or: [ cC inheritsFrom: dC ] ]) 
			ifTrue: [ self assert: (gen wantsEvent: (cC new currentTarget: e)) ]
			ifFalse: [ self deny: (gen wantsEvent: (cC new currentTarget: e)) ] ]
]
