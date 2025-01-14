"
A ToItemListElementTest is a test class for testing the behavior of ToItemListElement
"
Class {
	#name : #ToItemBarElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-List-Tests-ItemBar'
}

{ #category : #running }
ToItemBarElementTest >> setUp [

	super setUp.
	l := ToItemBarElementForTest new.
	l vMatchParent.
	space root addChild: l
]

{ #category : #tests }
ToItemBarElementTest >> test [

	| n |
	self assert: l nodes size equals: l dataAccessor size.
	self assert: (l nodeManager isKindOf: ToItemNodeManagerForTest).
	l addAllItems:
		((1 to: 10) collect: [ :i | ToItemElementForTest new text: i asString ]).
	n := l nodes first.
	self assert: (n isKindOf: ToItemNodeForTest).
	self assert: (n holder isKindOf: ToBarNodeHolderForTest).
	self assert: (n holder dataItem isKindOf: ToItemElementForTest)
	
]

{ #category : #tests }
ToItemBarElementTest >> testAddItem [

	| n item |
	item := ToItemElementForTest new text: '#1'.
	l addItem: item.
	self waitTestingSpaces.
	self assert: l nodes size equals: 1.
	n := l nodes first.
	self assert: (n isKindOf: ToItemNodeForTest).
	self assert: (n holder isKindOf: ToBarNodeHolderForTest).
	self assert: (n holder dataItem isKindOf: ToItemElementForTest).
	self assert: item barElement identicalTo: l.
	self assert: item positionInBar equals: 1
]

{ #category : #tests }
ToItemBarElementTest >> testDisableItemAfterAdding [

	| n item |
	self skip.
	self assert: l nodes size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	l addItem: item.
	item disable.
	n := l nodes first.
	self waitTestingSpaces.
	self assert: n holder dataItem identicalTo: item.
	self assert: (l disabledSelectionModel containsIndex: item positionInBar).
	self assert: item isDisabled.
	self assert: n isDisabled.


]

{ #category : #tests }
ToItemBarElementTest >> testDisableItemBeforeAdding [

	| n item |
	self skip.
	self assert: l nodes size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	item disabled: true.
	l addItem: item.
	self waitTestingSpaces.

	n := l nodes first.
	self assert: n holder dataItem identicalTo: item.
	self assert: item isDisabled.
	self assert: item positionInBar equals: 1.
	self assert: (l disabledSelectionModel containsIndex: item positionInBar).
	self assert: item isDisabled.
	self assert: n isDisabled.

]
