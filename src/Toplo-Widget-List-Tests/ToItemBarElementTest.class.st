"
A ToItemListElementTest is a test class for testing the behavior of ToItemListElement
"
Class {
	#name : #ToItemBarElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-List-Tests-ItemList'
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
	l dataAccessor addAll:
		((1 to: 10) collect: [ :i | ToItemElementForTest new text: i asString ]).
	n := l nodes first.
	self assert: (n isKindOf: ToItemNodeForTest).
	self assert: (n holder isKindOf: ToBarNodeHolderForTest).
	self assert: (n holder dataItem isKindOf: ToItemElementForTest)
	
]

{ #category : #tests }
ToItemBarElementTest >> testDisableItemAfterAdding [

	| n item |
	self skip.
	self assert: l nodes size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	l dataAccessor add: item.
	item disable.
	n := l nodes first.
	self waitTestingSpaces.
	self assert: n holder dataItem identicalTo: item.
	self assert: item isDisabled.
	self assert: n isDisabled
]

{ #category : #tests }
ToItemBarElementTest >> testDisableItemBeforeAdding [

	| n item |
	self skip.
	self assert: l nodes size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	item disable.
	l dataAccessor add: item.
	n := l nodes first.
	self waitTestingSpaces.
	self assert: n holder dataItem identicalTo: item.
	self assert: item isDisabled.
	self assert: n isDisabled
]
