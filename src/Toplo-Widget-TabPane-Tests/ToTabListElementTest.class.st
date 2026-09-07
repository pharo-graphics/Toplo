Class {
	#name : #ToTabListElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'tabList',
		'tab1',
		'tab2'
	],
	#category : #'Toplo-Widget-TabPane-Tests'
}

{ #category : #running }
ToTabListElementTest >> setUp [ 

	super setUp.
	tabList := ToTabListElement new.
	tabList toConfiguration isFlowable: false.
	tabList vertical: true.
	tabList vMatchParent.
	tabList hFitContent.
	space deferAndSettle: [ space root addChild: tabList ]
]

{ #category : #running }
ToTabListElementTest >> testAddOneItemAndSelect [

	tab1 := ToTabItemElement new.
	tab1 beHorizontal.
	tab1 width: 200.
	tab1 labelText: 'Hello'.

	space deferAndSettle: [ 
		tabList addItem: tab1.
		tab1 selected: true ].
	self assert: tab1 isSelected.
	self assert: tabList selectionModel selectedIndexesCount equals: 1.
	self assert: tab1 isChecked
]

{ #category : #running }
ToTabListElementTest >> testAddOneItemAndSelectAndDeselectAll [

	self testAddOneItemAndSelect.
	space deferAndSettle: [ tabList selecter deselectAll ].
	self assert: tabList selectionModel selectedIndexesCount equals: 0.
	self deny: tab1 isSelected.
	self deny: tab1 isChecked
]

{ #category : #running }
ToTabListElementTest >> testAddSelectedItemAndDeselectAll [

	self testAddTwoItemsAndSelect.
	space deferAndSettle: [ tabList selecter deselectAll ].
	self assert: tabList selectionModel selectedIndexesCount equals: 0
]

{ #category : #running }
ToTabListElementTest >> testAddTwoItemsAndSelect [
 
	tab1 := ToTabItemElement new.
	tab1 beHorizontal.
	tab1 width: 200.
	tab1 labelText: 'Hello'.

	tab2 := ToTabItemElement new.
	tab2 beHorizontal.
	tab2 width: 200.
	tab2 labelText: 'Goodbye'.

	space deferAndSettle: [ 
		tabList addItem: tab1.
		tab1 selected: true.
		tabList addItem: tab2.
		tab2 selected: true ].
	self deny: tab1 isChecked.
	self assert: tab2 isChecked.
	self assert: tabList selectionModel selectedIndexesCount equals: 1
]
