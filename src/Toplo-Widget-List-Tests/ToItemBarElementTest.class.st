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
	self assert: l nodes size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	l addItem: item.
	item disable.
	self waitTestingSpaces.
	
	n := l nodes first.
	self assert: n holder dataItem identicalTo: item.
	self assert: item positionInBar equals: 1.
	self assert: (l disabledSelectionModel containsIndex: item positionInBar).
	self assert: item isDisabled.
	self deny: n isDisabled.


]

{ #category : #tests }
ToItemBarElementTest >> testDisableItemAfterAdding2 [

	| n item|
	self assert: l nodes size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	l addItem: item.
	item := ToItemElementForTest new text: 'B'.
	l addItem: item.
	item disable.
	item := ToItemElementForTest new text: 'C'.
	l addItem: item.
	self waitTestingSpaces.
	
	n := l nodes first.
	self assert: n item positionInBar equals: 1.
	self deny: (l disabledSelectionModel containsIndex: n item positionInBar).
	self deny: n item isDisabled.
	self deny: n isDisabled.
	
	n := l nodes second.
	self waitTestingSpaces.
	self assert: n item positionInBar equals: 2.
	self assert: (l disabledSelectionModel containsIndex: n item positionInBar).
	self assert: n item isDisabled.
	self deny: n isDisabled.
	
	n := l nodes third.
	self assert: n item positionInBar equals: 3.
	self deny: (l disabledSelectionModel containsIndex: n item positionInBar).
	self deny: n item isDisabled.
	self deny: n isDisabled.
	



]

{ #category : #tests }
ToItemBarElementTest >> testDisableItemBeforeAdding [

	| n item |
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
	self deny: n isDisabled.

]

{ #category : #tests }
ToItemBarElementTest >> testDisableItemBeforeAdding2 [

	| n item|
	self assert: l nodes size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	l addItem: item.
	item := ToItemElementForTest new text: 'B'.
	item disable.
	l addItem: item.
	item := ToItemElementForTest new text: 'C'.
	l addItem: item.
	self waitTestingSpaces.
	
	n := l nodes first.
	self assert: n item positionInBar equals: 1.
	self deny: (l disabledSelectionModel containsIndex: n item positionInBar).
	self deny: n item isDisabled.
	self deny: n isDisabled.
	
	n := l nodes second.
	self waitTestingSpaces.
	self assert: n item positionInBar equals: 2.
	self assert: (l disabledSelectionModel containsIndex: n item positionInBar).
	self assert: n item isDisabled.
	self deny: n isDisabled.
	
	n := l nodes third.
	self assert: n item positionInBar equals: 3.
	self deny: (l disabledSelectionModel containsIndex: n item positionInBar).
	self deny: n item isDisabled.
	self deny: n isDisabled.
	

]
