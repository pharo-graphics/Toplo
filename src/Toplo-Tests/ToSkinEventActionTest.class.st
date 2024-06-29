Class {
	#name : #ToSkinEventActionTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-StyleSheet'
}

{ #category : #tests }
ToSkinEventActionTest >> testCanReceiveEvent [

	| action |
	action := ToSkinEventAction new.
	action eventClass: ToHoveredSkinEvent.
	self assert: (action canReceiveEvent: ToHoveredSkinEvent new).
	self deny: (action canReceiveEvent: ToLeavedSkinEvent new)
]

{ #category : #tests }
ToSkinEventActionTest >> testIsSupplement [

	| action |
	action := ToSkinEventAction new.
	self deny: action isSupplement
]

{ #category : #tests }
ToSkinEventActionTest >> testProperty [

	| action |
	action := ToSkinEventAction new.
	self assert: action property identicalTo: ToNullProperty uniqueInstance 

]

{ #category : #tests }
ToSkinEventActionTest >> testReceiveEvent [

	| w action evt |
	w := BlElement new.
	w background: Color red.
	evt := ToHoveredSkinEvent new currentTarget: w.
	action := ToSkinEventAction new.
	action eventClass: ToHoveredSkinEvent.
	action action: [ :e | e background: Color blue ].
	self assert: w background paint color equals: Color red.
	action receiveEvent: evt.
	self assert: w background paint color equals: Color blue.
	evt := ToLeavedSkinEvent new currentTarget: w.
	action receiveEvent: evt.
	self assert: w background paint color equals: Color blue

]
