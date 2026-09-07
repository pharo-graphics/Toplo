"
A ToMenuItemBarElementTest is a test class for testing the behavior of ToMenuItemBarElement
"
Class {
	#name : #ToMenuItemFiniteListElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-Menu-Tests-ItemFiniteList'
}

{ #category : #running }
ToMenuItemFiniteListElementTest >> setUp [

	super setUp.
	l := ToMenuItemListElement new.
	l vMatchParent.
	space deferAndSettle: [
		space root addChild: l ]
]

{ #category : #tests }
ToMenuItemFiniteListElementTest >> test [

	| n |
	self assert: l nodeContainers size equals: l dataAccessor size.
	self assert: (l nodeManager isKindOf: ToItemListNodeManager).

	space deferAndSettle: [
		l addAllItems:
			((1 to: 10) collect: [ :i | ToMenuItem new labelText: i asString ]) ].
	self assert: l nodeContainers size equals: 10.
	n := l nodeContainers first.
	self assert: (n node isKindOf: ToMenuItemNode).
	self assert: (n holder isKindOf: ToItemNodeHolder).
	self assert: (n holder dataItem isKindOf: ToMenuItem)
]

{ #category : #tests }
ToMenuItemFiniteListElementTest >> testAddItem [

	| n item |
	item := ToMenuItem new labelText: '#1'.
	space deferAndSettle: [ l addItem: item ].
	self assert: l nodeContainers size equals: 1.
	n := l nodeContainers first node.
	self assert: (n isKindOf: ToMenuItemNode).
	self assert: (n holder isKindOf: ToItemNodeHolder).
	self assert: (n holder dataItem isKindOf: ToMenuItem).
	self assert: item listElement identicalTo: l.
	self assert: item positionInList equals: 1
]

{ #category : #tests }
ToMenuItemFiniteListElementTest >> testDisableItemAfterAdding [

	| n item |
	self assert: l nodeContainers size equals: 0.
	item := ToMenuItem new labelText: 'A'.
	space deferAndSettle: [
		l addItem: item.
		item disable ].
	self assert: l nodeContainers size equals: 1.
	n := l nodeContainers first node.
	self assert: n holder dataItem identicalTo: item.
	self assert: item positionInList equals: 1.
	self assert:
		(l disabledSelectionModel containsIndex: item positionInList).
	self assert: item isDisabled.
	self assert: n isDisabled
]

{ #category : #tests }
ToMenuItemFiniteListElementTest >> testDisableItemAfterAdding2 [

	| n item |
	self assert: l nodes size equals: 0.
	item := ToMenuItem new labelText: 'A'.
	space deferAndSettle: [ l addItem: item ].
	item := ToMenuItem new labelText: 'B'.
	space deferAndSettle: [
		l addItem: item.
		item disable ].
	item := ToMenuItem new labelText: 'C'.
	space deferAndSettle: [ l addItem: item ].

	n := l nodes first.
	self assert: n item positionInList equals: 1.
	self deny:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self deny: n item isDisabled.
	self deny: n isDisabled.

	n := l nodes second.
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
ToMenuItemFiniteListElementTest >> testDisableItemBeforeAdding [

	| n item |
	self assert: l nodes size equals: 0.
	item := ToMenuItem new labelText: 'A'.
	item disabled: true.
	space deferAndSettle: [ l addItem: item ].

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
ToMenuItemFiniteListElementTest >> testDisableItemBeforeAdding2 [

	| n item |
	self assert: l nodes size equals: 0.
	item := ToMenuItem new labelText: 'A'.
	space deferAndSettle: [ l addItem: item ].
	item := ToMenuItem new labelText: 'B'.
	space deferAndSettle: [
		item disable.
		l addItem: item ].
	item := ToMenuItem new labelText: 'C'.
	space deferAndSettle: [ l addItem: item ].

	n := l nodes first.
	self assert: n item positionInList equals: 1.
	self deny:
		(l disabledSelectionModel containsIndex: n item positionInList).
	self deny: n item isDisabled.
	self deny: n isDisabled.

	n := l nodes second.
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
