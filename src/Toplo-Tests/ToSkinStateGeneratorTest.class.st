"
A ToSkinStateGeneratorTest is a test class for testing the behavior of ToSkinStateGenerator
"
Class {
	#name : #ToSkinStateGeneratorTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #'instance creation' }
ToSkinStateGeneratorTest >> newElementInSpace [

	| e |
	e := ToElement new.
	self assert: e skinManager skinInstaller isNil.
	space root addChild: e.
	self assert: e skinManager skinInstaller notNil.
	" to install the element skin  "
	space applyAllSkinInstallers.

	^ e
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testCheckableCheckEvent [

	self testGenerateCheckStateFromEvent 
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testGenerateCheckStateFromEvent [

	| e evt nextStates nextStatesSize |
	e := self newElementInSpace.

	nextStates := e skinManager skinStateQueue nextStates.

	nextStatesSize := nextStates size.

	evt := ToCheckableCheckEvent checked: false.

	self assert: nextStates size equals: nextStatesSize.

	e dispatchEvent: evt.
	self assert: nextStates size equals: nextStatesSize.
	e space phasesManager runStateGenerations.
	self assert: nextStates size equals: nextStatesSize + 1.

	nextStatesSize := nextStates size.

	evt := ToCheckableCheckEvent checked: false.
	e dispatchEvent: evt.
	e space phasesManager runStateGenerations.

	" no changed since the element is in the same state (2 successives uncheck) "
	self assert: nextStates size equals: nextStatesSize + 1.

	evt := ToCheckableCheckEvent checked: true.
	e dispatchEvent: evt.
	e space phasesManager runStateGenerations.
	self assert: nextStates size equals: nextStatesSize + 2
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testGenerateClickedStateFromEvent [

	| e evt nextStates nextStatesSize |
	e := self newElementInSpace.

	evt := BlMouseButton primary clickEventClass new button:
		       BlMouseButton primary.

	nextStates := e skinManager skinStateQueue nextStates.
	nextStatesSize := nextStates size.

	e dispatchEvent: evt.
	e space phasesManager runStateGenerations.
	self assert: nextStates size equals: nextStatesSize + 1.


	evt := BlMouseButton primary clickEventClass new button:
		       BlMouseButton primary.

	e dispatchEvent: evt.
	e space phasesManager runStateGenerations.
	self assert: nextStates size equals: nextStatesSize + 2
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testGenerateHoveredStateFromEvent [

	| e evt nextStates nextStatesSize |
	e := self newElementInSpace.

	evt := BlMouseEnterEvent new.

	nextStates := e skinManager skinStateQueue nextStates.
	nextStatesSize := nextStates size.

	e dispatchEvent: evt.
	e space phasesManager runStateGenerations.
	self assert: nextStates size equals: nextStatesSize + 1.

	evt := BlMouseEnterEvent new.

	e dispatchEvent: evt.
	e space phasesManager runStateGenerations.
	self assert: nextStates size equals: nextStatesSize + 2.

	evt := BlMouseLeaveEvent new.

	e dispatchEvent: evt.
	e space phasesManager runStateGenerations.

	self assert: nextStates size equals: nextStatesSize + 3
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testOnInstalledIn [

	| e h |
	e := ToElement new.
	h := e eventDispatcher handlers
		     detect: [ :handler | handler isKindOf: ToSkinStateGenerator ]
		     ifNone: [  ].
	self assert: h notNil.
	self assert: h target identicalTo: e.
	space root addChild: e
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
		       h isKindOf: ToSkinStateGenerator ] ifNone: [].
	self assert: gen notNil.
	space root addChild: e.
	gen := e eventDispatcher handlers detect: [ :h |
		       h isKindOf: ToSkinStateGenerator ].
	self assert: gen notNil.
	self assert: gen target identicalTo: e
]

{ #category : #tests }
ToSkinStateGeneratorTest >> testWantsEvent [

	| e gen  |
	e := ToElement new.
	space root addChild: e.
	self assert: e isEnabled.
	gen := e eventDispatcher handlers detect: [ :h |
		       h isKindOf: ToSkinStateGenerator ].
	gen eventsToHandle do: [ :cC |
		self assert: (gen wantsEvent: (cC new currentTarget: e)) ].
	e disable.
	self deny: e isEnabled.
	gen eventsToHandle do: [ :cC | self assert: (gen wantsEvent: (cC new currentTarget: e)) ].
]
