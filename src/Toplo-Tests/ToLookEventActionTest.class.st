Class {
	#name : #ToLookEventActionTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-StyleSheet'
}

{ #category : #tests }
ToLookEventActionTest >> testCanReceiveEvent [

	| action |
	action := ToLookEventAction new.
	action eventClass: ToHoveredSkinEvent.
	self assert: (action canReceiveEvent: ToHoveredSkinEvent new).
	self deny: (action canReceiveEvent: ToLeavedSkinEvent new)
]

{ #category : #tests }
ToLookEventActionTest >> testIsSupplement [

	| action |
	action := ToLookEventAction new.
	self deny: action isSupplement
]

{ #category : #tests }
ToLookEventActionTest >> testProperty [

	| action |
	action := ToLookEventAction new.
	self assert: action property identicalTo: ToNullProperty uniqueInstance 

]

{ #category : #tests }
ToLookEventActionTest >> testReceiveEvent [

	| w action evt |
	w := BlElement new.
	w background: Color red.
	evt := ToHoveredSkinEvent new currentTarget: w.
	action := ToLookEventAction new.
	action eventClass: ToHoveredSkinEvent.
	action action: [ :e | e background: Color blue ].
	self assert: w background paint color equals: Color red.
	action receiveEvent: evt.
	self assert: w background paint color equals: Color blue.
	evt := ToLeavedSkinEvent new currentTarget: w.
	action receiveEvent: evt.
	self assert: w background paint color equals: Color blue

]
