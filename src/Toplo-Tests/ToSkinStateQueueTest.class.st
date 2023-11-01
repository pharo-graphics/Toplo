"
A ToSkinnableEventHandlerTest is a test class for testing the behavior of ToSkinnableEventHandler
"
Class {
	#name : #ToSkinStateQueueTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Skin'
}

{ #category : #tests }
ToSkinStateQueueTest >> newElementInSpace [

	| e |
	e := ToElement new.
	self assert: e skinInstaller isNil.
	space root addChild: e.
	self assert: e skinInstaller notNil.
	" procesPulse here to install the element skin by the phase "
	space processPulse.

	^ e

	
]

{ #category : #running }
ToSkinStateQueueTest >> setUp [ 
	super setUp.
	space := self newTestingSpace
]

{ #category : #tests }
ToSkinStateQueueTest >> testCheckableCheckedEvent [

	self testGenerateCheckStateFromEvent 
]

{ #category : #tests }
ToSkinStateQueueTest >> testGenerateCheckStateFromEvent [

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
		equals: nextStatesSize.
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
ToSkinStateQueueTest >> testGenerateClickedStateFromEvent [

	| e evt nextStates currentStates |
	e := self newElementInSpace.

	evt := BlMouseButton primary clickEventClass new button: BlMouseButton primary.

	nextStates := e skinStateQueue nextStates.
	currentStates := e skinStateQueue currentStates.

	self assert: nextStates size equals: 0.
	" has ToEnabledState "
	self assert: currentStates size equals: 1.
	self assert: (currentStates first isKindOf: ToEnabledState).

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToClickedState ]) size
		equals: 1.
	self assert: nextStates size equals: 1.

	" ClickState is not persistent but EnabledState is persistent"
	self assert: currentStates size equals: 1.
	self assert: (currentStates first isKindOf: ToEnabledState).


	evt := BlMouseButton primary clickEventClass new button:
		       BlMouseButton primary.

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToClickedState ]) size
		equals: 1.
	self assert: currentStates size equals: 1.
	self assert: (currentStates first isKindOf: ToEnabledState).

]

{ #category : #tests }
ToSkinStateQueueTest >> testGenerateHoveredStateFromEvent [

	| e evt nextStates currentStates |
	e := self newElementInSpace.

	evt := BlMouseEnterEvent new.

	nextStates := e skinStateQueue nextStates.
	currentStates := e skinStateQueue currentStates.

	self assert: nextStates size equals: 0.
	" has ToEnabledState "
	self assert: currentStates size equals: 1.
	self assert: (currentStates first isKindOf: ToEnabledState).

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToHoveredState ]) size
		equals: 1.
	self assert: nextStates size equals: 1.

	" ToHoveredState is persistent "
	self assert: currentStates size equals: 2.


	evt := BlMouseEnterEvent new.

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToHoveredState ]) size
		equals: 1.
	self assert: currentStates size equals: 2.

	evt := BlMouseLeaveEvent new.

	e dispatchEvent: evt.

	self
		assert: (nextStates select: [ :s | s isKindOf: ToLeavedState ]) size
		equals: 1.
	" ToEnabledState remains and ToLeavedState isNot persistent, ToHoveredState should have been removed "
	self assert: currentStates size equals: 1
]

{ #category : #'api - hooks' }
ToSkinStateQueueTest >> testOnInstalledIn [

	| e h |
	e := ToElement new.
	h := ToSkinStateGenerator new.
	e addEventHandler: h.
	self assert: h target identicalTo: e.
	e removeEventHandler: h.
	self assert: h target isNil
]

{ #category : #'api - hooks' }
ToSkinStateQueueTest >> testOnUninstalledIn [

	self testOnInstalledIn
]

{ #category : #accessing }
ToSkinStateQueueTest >> testTarget [

	self testOnInstalledIn 
]

{ #category : #'api event managing' }
ToSkinStateQueueTest >> testWantsEvent [

	| e h eventsToHandle eventsToHandleWhenDisabled |
	e := ToElement new.
	h := ToSkinStateGenerator new.
	e addEventHandler: h.
	self assert: e isEnabled.
	eventsToHandle := h eventsToHandle.
	eventsToHandle do: [ :cC |
		self assert: (h wantsEvent: (cC new currentTarget: e)) ].
	e disable.
	self deny: e isEnabled.
	eventsToHandleWhenDisabled := h eventsToHandleWhenDisabled.
	eventsToHandleWhenDisabled do: [ :cC | self assert: (h wantsEvent: (cC new currentTarget: e)) ].
	eventsToHandle do: [ :cC | 
		(eventsToHandleWhenDisabled anySatisfy: [:dC | cC == dC or: [ cC inheritsFrom: dC ] ]) 
			ifTrue: [ self assert: (h wantsEvent: (cC new currentTarget: e)) ]
			ifFalse: [ self deny: (h wantsEvent: (cC new currentTarget: e)) ] ]
]
