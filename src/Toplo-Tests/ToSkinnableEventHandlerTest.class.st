"
A ToSkinnableEventHandlerTest is a test class for testing the behavior of ToSkinnableEventHandler
"
Class {
	#name : #ToSkinnableEventHandlerTest,
	#superclass : #BlParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core'
}

{ #category : #running }
ToSkinnableEventHandlerTest >> setUp [ 
	super setUp.
	space := self newTestingSpace
]

{ #category : #'api - hooks' }
ToSkinnableEventHandlerTest >> testOnInstalledIn [

	| e h |
	e := ToElement new.
	h := ToSkinnableEventHandler new.
	e addEventHandler: h.
	self assert: h target identicalTo: e.
	e removeEventHandler: h.
	self assert: h target isNil
]

{ #category : #'api - hooks' }
ToSkinnableEventHandlerTest >> testOnUninstalledIn [

	self testOnInstalledIn
]

{ #category : #accessing }
ToSkinnableEventHandlerTest >> testTarget [

	self testOnInstalledIn 
]

{ #category : #'api event managing' }
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
