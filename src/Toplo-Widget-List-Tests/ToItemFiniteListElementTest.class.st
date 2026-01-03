"
A ToItemListElementTest is a test class for testing the behavior of ToItemListElement
"
Class {
	#name : #ToItemFiniteListElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-List-Tests-ItemFiniteList'
}

{ #category : #running }
ToItemFiniteListElementTest >> setUp [

	super setUp.
	l := ToItemFiniteListElementForTest new.
	l vMatchParent.
	space root addChild: l
]

{ #category : #tests }
ToItemFiniteListElementTest >> test [

	| n |
	self assert: l nodeContainers size equals: l dataAccessor size.
	self assert: (l nodeManager isKindOf: ToItemListNodeManager).
	l addAllItems:
		((1 to: 10) collect: [ :i | ToItemElementForTest new text: i asString ]).
	self waitTestingSpaces.
	n := l nodes first.
	self assert: (n isKindOf: ToItemNodeForTest).
	self assert: (n holder isKindOf: ToFiniteListNodeHolderForTest).
	self assert: (n holder dataItem isKindOf: ToItemElementForTest)
	
]

{ #category : #tests }
ToItemFiniteListElementTest >> testAddItem [

	| n item |
	item := ToItemElementForTest new text: '#1'.
	l addItem: item.
	self waitTestingSpaces.
	self assert: l nodeContainers size equals: 1.
	n := l nodes first.
	self assert: (n isKindOf: ToItemNodeForTest).
	self assert: (n holder isKindOf: ToFiniteListNodeHolderForTest).
	self assert: (n holder dataItem isKindOf: ToItemElementForTest).
	self assert: item listElement identicalTo: l.
	self assert: item positionInList equals: 1
]

{ #category : #tests }
ToItemFiniteListElementTest >> testDisableItemAfterAdding [

	| n item |
	self assert: l nodeContainers size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	l addItem: item.
	item disable.
	self waitTestingSpaces.

	n := l nodes first.
	self assert: n holder dataItem identicalTo: item.
	self assert: item positionInList equals: 1.
	self assert:
		(l disabledSelectionModel containsIndex: item positionInList).
	self assert: item isDisabled.
	self assert: n isDisabled
]

{ #category : #tests }
ToItemFiniteListElementTest >> testDisableItemAfterAdding2 [

	| n item |
	self assert: l nodeContainers size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	l addItem: item.
	item := ToItemElementForTest new text: 'B'.
	l addItem: item.
	item disable.
	item := ToItemElementForTest new text: 'C'.
	l addItem: item.
	self waitTestingSpaces.

	n := l nodes first.
	self assert: n item positionInList equals: 1.
	self deny:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self deny: n item isDisabled.
	self deny: n isDisabled.

	n := l nodes second.
	self waitTestingSpaces.
	self assert: n item positionInList equals: 2.
	self assert:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self assert: n item isDisabled.
	self assert: n isDisabled.

	n := l nodes third.
	self assert: n item positionInList equals: 3.
	self deny:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self deny: n item isDisabled.
	self deny: n isDisabled
]

{ #category : #tests }
ToItemFiniteListElementTest >> testDisableItemBeforeAdding [

	| n item |
	self assert: l nodeContainers size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	item disabled: true.
	l addItem: item.
	self waitTestingSpaces.

	n := l nodes first.
	self assert: n holder dataItem identicalTo: item.
	self assert: item isDisabled.
	self assert: item positionInList equals: 1.
	self assert:
		(l disabledSelectionModel containsIndex: item positionInList).
	self assert: item isDisabled.
	self assert: n isDisabled
]

{ #category : #tests }
ToItemFiniteListElementTest >> testDisableItemBeforeAdding2 [

	| n item |
	self assert: l nodeContainers size equals: 0.
	item := ToItemElementForTest new text: 'A'.
	l addItem: item.
	item := ToItemElementForTest new text: 'B'.
	item disable.
	l addItem: item.
	item := ToItemElementForTest new text: 'C'.
	l addItem: item.
	self waitTestingSpaces.

	n := l nodes first.
	self assert: n item positionInList equals: 1.
	self deny:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self deny: n item isDisabled.
	self deny: n isDisabled.

	n := l nodes second.
	self waitTestingSpaces.
	self assert: n item positionInList equals: 2.
	self assert:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self assert: n item isDisabled.
	self assert: n isDisabled.

	n := l nodes third.
	self assert: n item positionInList equals: 3.
	self deny:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self deny: n item isDisabled.
	self deny: n isDisabled
]
