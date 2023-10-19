"
A ToSkinnableEventHandlerTest is a test class for testing the behavior of ToSkinnableEventHandler
"
Class {
	#name : 'ToSkinnableEventHandlerTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core',
	#package : 'Toplo-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
ToSkinnableEventHandlerTest >> newElementInSpace [

	| e |
	e := ToElement new.
	e addEventHandler: ToSkinnableEventHandler new.
	self assert: e skinInstaller isNil.
	space root addChild: e.
	self assert: e skinInstaller notNil.
	^ e

	
]

{ #category : 'running' }
ToSkinnableEventHandlerTest >> setUp [ 
	super setUp.
	space := self newTestingSpace
]

{ #category : 'tests' }
ToSkinnableEventHandlerTest >> testAddCheckStateEvent [

	| e evt nextStates currentStates |
	e := self newElementInSpace.

	evt := ToCheckableCheckedEvent new
		       current: false;
		       previous: true;
		       yourself.

	nextStates := e skinStateEngine nextStates.
	currentStates := e skinStateEngine currentStates.

	self assert: nextStates size equals: 0.
	self assert: currentStates size equals: 0.

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToUncheckedState ]) size
		equals: 1.
	self assert: nextStates size equals: 1.
	self
		assert:
		(currentStates select: [ :s | s isKindOf: ToUncheckedState ]) size
		equals: 1.
	self assert: currentStates size equals: 1.


	evt := ToCheckableCheckedEvent new
		       current: false;
		       previous: true;
		       yourself.
	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToUncheckedState ]) size
		equals: 1.
	self
		assert:
		(currentStates select: [ :s | s isKindOf: ToUncheckedState ]) size
		equals: 1.

	evt := ToCheckableCheckedEvent new
		       current: true;
		       previous: false;
		       yourself.
	e dispatchEvent: evt.
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

{ #category : 'tests' }
ToSkinnableEventHandlerTest >> testAddClickedStateEvent [

	| e evt nextStates currentStates |
	e := self newElementInSpace.

	evt := BlMouseButton primary clickEventClass new button:
		       BlMouseButton primary.

	nextStates := e skinStateEngine nextStates.
	currentStates := e skinStateEngine currentStates.

	self assert: nextStates size equals: 0.
	self assert: currentStates size equals: 0.

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToClickedState ]) size
		equals: 1.
	self assert: nextStates size equals: 1.

	" ClickState is not persistent "
	self assert: currentStates size equals: 0.


	evt := BlMouseButton primary clickEventClass new button:
		       BlMouseButton primary.

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToClickedState ]) size
		equals: 1.
	self assert: currentStates size equals: 0
]

{ #category : 'tests' }
ToSkinnableEventHandlerTest >> testAddHoveredStateEvent [

	| e evt nextStates currentStates |
	e := self newElementInSpace.

	evt := BlMouseEnterEvent new.

	nextStates := e skinStateEngine nextStates.
	currentStates := e skinStateEngine currentStates.

	self assert: nextStates size equals: 0.
	self assert: currentStates size equals: 0.

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToHoveredState ]) size
		equals: 1.
	self assert: nextStates size equals: 1.

	" ClickState is not persistent "
	self assert: currentStates size equals: 1.


	evt := BlMouseEnterEvent new.

	e dispatchEvent: evt.
	self
		assert:
		(nextStates select: [ :s | s isKindOf: ToHoveredState ]) size
		equals: 1.
	self assert: currentStates size equals: 1.

	evt := BlMouseLeaveEvent new.

	e dispatchEvent: evt.

	self
		assert: (nextStates select: [ :s | s isKindOf: ToLeavedState ]) size
		equals: 1.
	self assert: currentStates size equals: 0
]

{ #category : 'tests' }
ToSkinnableEventHandlerTest >> testCheckableCheckEvent [

	self testAddCheckStateEvent 
]

{ #category : 'api - hooks' }
ToSkinnableEventHandlerTest >> testOnInstalledIn [

	| e h |
	e := ToElement new.
	h := ToSkinnableEventHandler new.
	e addEventHandler: h.
	self assert: h target identicalTo: e.
	e removeEventHandler: h.
	self assert: h target isNil
]

{ #category : 'api - hooks' }
ToSkinnableEventHandlerTest >> testOnUninstalledIn [

	self testOnInstalledIn
]

{ #category : 'accessing' }
ToSkinnableEventHandlerTest >> testTarget [

	self testOnInstalledIn 
]

{ #category : 'api event managing' }
ToSkinnableEventHandlerTest >> testWantsEvent [

	| e h eventsToHandle eventsToHandleWhenDisabled |
	e := ToElement new.
	h := ToSkinnableEventHandler new.
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
