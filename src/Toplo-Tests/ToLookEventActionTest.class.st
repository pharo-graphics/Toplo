Class {
	#name : 'ToLookEventActionTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 'running' }
ToLookEventActionTest >> setUp [ 

	super setUp.
	space := self newTestingSpace
]

{ #category : 'tests' }
ToLookEventActionTest >> testCanReceiveEvent [

	| action |
	action := ToLookEventAction new.
	action eventClass: ToHoveredLookEvent.
	self assert: (action canReceiveEvent: ToHoveredLookEvent new).
	self deny: (action canReceiveEvent: ToLeavedLookEvent new)
]

{ #category : 'tests' }
ToLookEventActionTest >> testIsSupplement [

	| action |
	action := ToLookEventAction new.
	self deny: action isSupplement
]

{ #category : 'tests' }
ToLookEventActionTest >> testProperty [

	| action |
	action := ToLookEventAction new.
	self assert: action property identicalTo: ToNullProperty uniqueInstance 

]

{ #category : 'tests' }
ToLookEventActionTest >> testReceiveEvent [

	| w action evt |
	w := BlElement new.
	w background: Color red.
	evt := ToHoveredLookEvent new currentTarget: w.
	action := ToLookEventAction new.
	action eventClass: ToHoveredLookEvent.
	action action: [ :e | e background: Color blue ].
	self assert: w background paint color equals: Color red.
	action receiveEvent: evt.
	self assert: w background paint color equals: Color blue.
	evt := ToLeavedLookEvent new currentTarget: w.
	action receiveEvent: evt.
	self assert: w background paint color equals: Color blue

]