"
A ToTabListElementTest is a test class for testing the behavior of ToTabListElement
"
Class {
	#name : #ToTabListElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'tabList',
		'tab1',
		'tab2'
	],
	#category : #'Toplo-Widget-TabPane-Tests-TabList'
}

{ #category : #running }
ToTabListElementTest >> setUp [ 

	super setUp.
	tabList := ToTabListElement new.
	tabList toConfiguration isFlowable: false.
	tabList vertical: true.
	tabList vMatchParent.
	tabList hFitContent.
	space root addChild: tabList
]

{ #category : #running }
ToTabListElementTest >> testAddOneItemAndSelect [

	tab1 := ToTabItemElement new.
	tab1 beHorizontal.
	tab1 width: 200.
	tab1 labelText: 'Hello'.

	tabList addItem: tab1.
	tab1 selected: true.

	self waitTestingSpaces.
	self assert: tab1 isChecked.
	self assert: tabList selectionModel selectedIndexesCount equals: 1
]

{ #category : #running }
ToTabListElementTest >> testAddOneItemAndSelectAndDeselectAll [

	self testAddOneItemAndSelect.
	tabList selecter deselectAll.
	self waitTestingSpaces.
	self deny: tab1 isChecked.
	self deny: tab1 isSelected.
	self assert: tabList selectionModel selectedIndexesCount equals: 0.

]

{ #category : #running }
ToTabListElementTest >> testAddSelectedItemAndDeselectAll [

	self testAddTwoItemsAndSelect.
	tabList selecter deselectAll.
	self waitTestingSpaces.
	self assert: tabList selectionModel selectedIndexesCount equals: 0
]

{ #category : #running }
ToTabListElementTest >> testAddTwoItemsAndSelect [
 
	tab1 := ToTabItemElement new.
	tab1 beHorizontal.
	tab1 width: 200.
	tab1 labelText: 'Hello'.

	tabList addItem: tab1.
	tab1 selected: true.

	tab2 := ToTabItemElement new.
	tab2 beHorizontal.
	tab2 width: 200.
	tab2 labelText: 'Goodbye'.

	tabList addItem: tab2.
	tab2 selected: true.
	self waitTestingSpaces.
	self deny: tab1 isChecked.
	self assert: tab2 isChecked.
	self assert: tabList selectionModel selectedIndexesCount equals: 1
]
