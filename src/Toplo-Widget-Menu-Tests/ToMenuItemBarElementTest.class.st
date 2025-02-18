"
A ToMenuItemBarElementTest is a test class for testing the behavior of ToMenuItemBarElement
"
Class {
	#name : #ToMenuItemBarElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-Menu-Tests-ItemBar'
}

{ #category : #running }
ToMenuItemBarElementTest >> setUp [

	super setUp.
	l := ToMenuItemBarElement new.
	l vMatchParent.
	space root addChild: l
]

{ #category : #tests }
ToMenuItemBarElementTest >> test [

	| n |
	self assert: l nodes size equals: l dataAccessor size.
	self assert: (l nodeManager isKindOf: ToMenuItemNodeManager).
	l addAllItems:
		((1 to: 10) collect: [ :i | ToMenuItem new labelText: i asString ]).
	n := l nodes first.
	self assert: (n isKindOf: ToMenuItemNode).
	self assert: (n holder isKindOf: ToItemNodeHolder).
	self assert: (n holder dataItem isKindOf: ToMenuItem)
	
]

{ #category : #tests }
ToMenuItemBarElementTest >> testAddItem [

	| n item |
	item := ToMenuItem new labelText: '#1'.
	l addItem: item.
	self waitTestingSpaces.
	self assert: l nodes size equals: 1.
	n := l nodes first.
	self assert: (n isKindOf: ToMenuItemNode).
	self assert: (n holder isKindOf: ToItemNodeHolder).
	self assert: (n holder dataItem isKindOf: ToMenuItem).
	self assert: item listElement identicalTo: l.
	self assert: item positionInList equals: 1
]

{ #category : #tests }
ToMenuItemBarElementTest >> testDisableItemAfterAdding [

	| n item |
	self assert: l nodes size equals: 0.
	item := ToMenuItem new labelText: 'A'.
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
ToMenuItemBarElementTest >> testDisableItemAfterAdding2 [

	| n item |
	self assert: l nodes size equals: 0.
	item := ToMenuItem new labelText: 'A'.
	l addItem: item.
	item := ToMenuItem new labelText: 'B'.
	l addItem: item.
	item disable.
	item := ToMenuItem new labelText: 'C'.
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
	self assert: n item positionInBar equals: 3.
	self deny:
		(l disabledSelectionModel containsIndex: n item positionInBar).
	self deny: n item isDisabled.
	self deny: n isDisabled
]

{ #category : #tests }
ToMenuItemBarElementTest >> testDisableItemBeforeAdding [

	| n item |
	self assert: l nodes size equals: 0.
	item := ToMenuItem new labelText: 'A'.
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
ToMenuItemBarElementTest >> testDisableItemBeforeAdding2 [

	| n item |
	self assert: l nodes size equals: 0.
	item := ToMenuItem new labelText: 'A'.
	l addItem: item.
	item := ToMenuItem new labelText: 'B'.
	item disable.
	l addItem: item.
	item := ToMenuItem new labelText: 'C'.
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
	self assert: n item positionInBar equals: 3.
	self deny:
		(l disabledSelectionModel containsIndex: n item positionInBar).
	self deny: n item isDisabled.
	self deny: n isDisabled
]
