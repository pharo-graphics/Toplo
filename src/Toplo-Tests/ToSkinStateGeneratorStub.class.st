"
A ToSkinStateGeneratorTest is a test class for testing the behavior of ToSkinStateGenerator
"
Class {
	#name : #ToSkinStateGeneratorStub,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #'instance creation' }
ToSkinStateGeneratorStub >> newElementInSpace [

	| e |
	e := ToElement new.
	self assert: e skinManager skinInstaller isNil.
	space root addChild: e.
	self assert: e skinManager skinInstaller notNil.
	" to install the element skin  "
	space applyAllSkinInstallers.
	space runStateGenerations.

	^ e
]

{ #category : #tests }
ToSkinStateGeneratorStub >> testCheckableCheckEvent [

	self testGenerateCheckStateFromEvent 
]

{ #category : #tests }
ToSkinStateGeneratorStub >> testGenerateCheckStateFromEvent [

	| e evt nextStates nextStatesSize |
	e := self newElementInSpace.

	nextStates := e skinManager skinStateQueue nextStates.

	nextStatesSize := nextStates size.

	evt := ToCheckableCheckEvent new
		       current: false;
		       previous: true;
		       yourself.

	self assert: nextStates size equals: nextStatesSize.

	e dispatchEvent: evt.
	self assert: nextStates size equals: nextStatesSize.
	e space runStateGenerations.
	self assert: nextStates size equals: nextStatesSize + 1.

	nextStatesSize := nextStates size.

	evt := ToCheckableCheckEvent new
		       current: false;
		       previous: true;
		       yourself.
	e dispatchEvent: evt.
	e space runStateGenerations.

	" no changed since the element is in the same state (2 successives uncheck) "
	self assert: nextStates size equals: nextStatesSize + 1.

	evt := ToCheckableCheckEvent new
		       current: true;
		       previous: false;
		       yourself.
	e dispatchEvent: evt.
	e space runStateGenerations.
	self assert: nextStates size equals: nextStatesSize + 2
]

{ #category : #tests }
ToSkinStateGeneratorStub >> testGenerateClickedStateFromEvent [

	| e evt nextStates nextStatesSize |
	e := self newElementInSpace.

	evt := BlMouseButton primary clickEventClass new button:
		       BlMouseButton primary.

	nextStates := e skinManager skinStateQueue nextStates.
	nextStatesSize := nextStates size.

	e dispatchEvent: evt.
	e space runStateGenerations.
	self assert: nextStates size equals: nextStatesSize + 1.


	evt := BlMouseButton primary clickEventClass new button:
		       BlMouseButton primary.

	e dispatchEvent: evt.
	e space runStateGenerations.
	self assert: nextStates size equals: nextStatesSize + 2
]

{ #category : #tests }
ToSkinStateGeneratorStub >> testGenerateHoveredStateFromEvent [

	| e evt nextStates nextStatesSize |
	e := self newElementInSpace.

	evt := BlMouseEnterEvent new.

	nextStates := e skinManager skinStateQueue nextStates.
	nextStatesSize := nextStates size.

	e dispatchEvent: evt.
	e space runStateGenerations.
	self assert: nextStates size equals: nextStatesSize + 1.

	evt := BlMouseEnterEvent new.

	e dispatchEvent: evt.
	e space runStateGenerations.
	self assert: nextStates size equals: nextStatesSize + 2.

	evt := BlMouseLeaveEvent new.

	e dispatchEvent: evt.
	e space runStateGenerations.

	self assert: nextStates size equals: nextStatesSize + 3
]

{ #category : #tests }
ToSkinStateGeneratorStub >> testOnInstalledIn [

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
ToSkinStateGeneratorStub >> testOnUninstalledIn [

	self testOnInstalledIn
]

{ #category : #tests }
ToSkinStateGeneratorStub >> testTarget [

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
ToSkinStateGeneratorStub >> testWantsEvent [

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
	gen eventsToHandle do: [ :cC | self deny: (gen wantsEvent: (cC new currentTarget: e)) ].
]
