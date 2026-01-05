"
A ToMenuTest is a test class for testing the behavior of ToMenu
"
Class {
	#name : #ToMenuTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'm'
	],
	#category : #'Toplo-Widget-Menu-Tests-Items'
}

{ #category : #running }
ToMenuTest >> setUp [

	super setUp. 
	m := ToMenu new labelText: 'Menu'.
	space root addChild: m
]

{ #category : #tests }
ToMenuTest >> testAddItem [

	| n item |
	item := ToMenuItem new labelText: 'Menu'.
	m addItem: item.
	m popupEvent: nil.
	self waitTestingSpaces.
	self assert: m menuWindow itemList nodes size equals: 1.
	n := m manager currentWindow itemList nodes first.
	self assert: (n isKindOf: ToMenuItemNode).
	self assert: (n holder isKindOf: ToItemNodeHolder).
	self assert: (n holder dataItem isKindOf: ToMenuItem).
	self assert: item listElement identicalTo: m menuWindow itemList.
	self assert: item positionInList equals: 1
]

{ #category : #tests }
ToMenuTest >> testBuilderDisableItemAfterAdding [

	| n item |
	m builder: [ :theMenu :theRequest |
		item := ToMenuItem new labelText: 'Item #1'.
		theMenu addItem: item.
		item disable ].
	m popupEvent: nil.
	self waitTestingSpaces.
	self assert: m menuWindow itemList nodes size equals: 1.
	n := m menuWindow itemList nodes first.
	self assert:
		(m menuWindow itemList disabledSelectionModel containsIndex:
			 item positionInList).
	self assert: item isDisabled.
	self assert: n isDisabled
]

{ #category : #tests }
ToMenuTest >> testBuilderDisableItemBeforeAdding [

	| n item |
	m builder: [ :theMenu :theRequest |
		item := ToMenuItem new labelText: 'Item #1'.
		item disable.
		theMenu addItem: item ].
	m popupEvent: nil.
	self waitTestingSpaces.
	self assert: m menuWindow itemList nodes size equals: 1.
	n := m menuWindow itemList nodes first.
	self assert:
		(m menuWindow itemList disabledSelectionModel containsIndex:
			 item positionInList).
	self assert: item isDisabled.
	self assert: n isDisabled
]

{ #category : #tests }
ToMenuTest >> testDisableItemAfterAdding [

	| n item |
	item := ToMenuItem new labelText: 'Item #1'.
	m addItem: item.
	item disable.
	m popupEvent: nil.
	self waitTestingSpaces.
	self assert: m menuWindow itemList nodes size equals: 1.
	n := m menuWindow itemList nodes first.
	self assert:
		(m menuWindow itemList disabledSelectionModel containsIndex:
			 item positionInList).
	self assert: item isDisabled.
	self assert: n isDisabled
]

{ #category : #tests }
ToMenuTest >> testDisableItemBeforeAdding [

	| n item |
	item := ToMenuItem new labelText: 'Menu'.
	item disable.
	m addItem: item.
	m popupEvent: nil.
	self waitTestingSpaces.
	self assert: m menuWindow itemList nodes size equals: 1.
	n := m menuWindow itemList nodes first.
	self assert:
		(m menuWindow itemList disabledSelectionModel containsIndex:
			 item positionInList).
	self assert: item isDisabled.
	self assert: n isDisabled
]
