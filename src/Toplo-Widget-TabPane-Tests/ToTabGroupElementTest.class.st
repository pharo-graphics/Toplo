"
A ToTabPaneElementTest is a test class for testing the behavior of ToTabPaneElement
"
Class {
	#name : #ToTabGroupElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'tabGroup'
	],
	#category : #'Toplo-Widget-TabPane-Tests-TabGroup'
}

{ #category : #tests }
ToTabGroupElementTest >> itemCheckedBeforeAddedInSpace [

	| firstItem |
	tabGroup addItem: (ToTabItemElement new
			 id: #first;
			 labelText: 'First';
			 yourself).

	" in case of infinite element, the layout must be done, 
	so it means that an item can't be selected before 
	the tabGroup is added in a space "
	firstItem := tabGroup items first.
	self deny: firstItem isSelected.
	tabGroup itemList useInfiniteLayout
		ifTrue: [ tabGroup selecter selectIndex: 1 ]
		ifFalse: [ firstItem checked: true ].
	self assert: firstItem isChecked.

	space deferAndSettle: [ space root addChild: tabGroup ].
	self assert: firstItem isSelected
]

{ #category : #tests }
ToTabGroupElementTest >> itemSelectedBeforeAddedInSpace [

	| firstItem |
	tabGroup addItem:
		(ToTabItemElement new
			 id: #first;
			 labelText: 'First';
			 yourself).

	firstItem := tabGroup items first.
	self deny: firstItem isSelected.

	" in case of infinite element, the layout must be done, 
	so it means that an item can't be selected before 
	the tabGroup is added in a space "
	tabGroup selecter selectIndex: 1.
	tabGroup itemList useInfiniteLayout ifFalse: [
		self assert: firstItem isChecked.
		self assert: firstItem isSelected ].

	space deferAndSettle: [ space root addChild: tabGroup ].
	self assert: firstItem isChecked.
	self assert: firstItem isSelected
]

{ #category : #running }
ToTabGroupElementTest >> setUp [

	super setUp.
	tabGroup := ToTabGroupElement new.
	tabGroup matchParent.
	space deferAndSettle: [ space root addChild: tabGroup ]
]

{ #category : #tests }
ToTabGroupElementTest >> testFiniteItemCheckedBeforeAddedInSpace [

	tabGroup := ToTabGroupElement new.
	tabGroup itemList useInfiniteLayout: false.
	self itemCheckedBeforeAddedInSpace 
]

{ #category : #tests }
ToTabGroupElementTest >> testFiniteItemSelectedBeforeAddedInSpace [

	tabGroup := ToTabGroupElement new.
	tabGroup itemList useInfiniteLayout: false.
	self itemSelectedBeforeAddedInSpace 
]

{ #category : #tests }
ToTabGroupElementTest >> testInfiniteItemCheckedBeforeAddedInSpace [

	" Notice that a tabgroup is not made to be used in an infinite.
	To be checked/fixed later if possible "
	tabGroup := ToTabGroupElement new.
	tabGroup itemList useInfiniteLayout: true.
	self itemCheckedBeforeAddedInSpace 
]

{ #category : #tests }
ToTabGroupElementTest >> testInfiniteItemSelectedBeforeAddedInSpace [

	" Notice that a tabgroup is not made to be used in an infinite.
	To be checked/fixed later if possible "
	tabGroup := ToTabGroupElement new.
	tabGroup itemList useInfiniteLayout: true.
	self itemSelectedBeforeAddedInSpace 
]

{ #category : #tests }
ToTabGroupElementTest >> testIsSelected [

	| firstItem secondItem |
	self withTwoTabItems.
	firstItem := tabGroup items first.
	secondItem := tabGroup items second.

	self deny: firstItem isSelected.
	self deny: secondItem isSelected.

	secondItem eventSimulator click.
	self assert: secondItem isSelected.
	self deny: firstItem isSelected
]

{ #category : #tests }
ToTabGroupElementTest >> testRemoveAllItems [
	"first selected before, remove first button, second selected after "

	| firstButton secondButton |
	self withTwoTabItems.
	firstButton := tabGroup items first.
	secondButton := tabGroup items second.
	space deferAndSettle: [
		firstButton removable: true.
		secondButton removable: true  ].
	firstButton eventSimulator click.
	self assert: firstButton isSelected.
	self deny: secondButton isSelected.

	space deferAndSettle: [ tabGroup removeAllItems  ].
	self assert: tabGroup items size equals: 0.
	self assert: tabGroup itemList items size equals: 0.
	self assert: tabGroup itemList innerElement nodeContainers size equals: 0.
	" the fake node remains "
	self assert: tabGroup itemList innerElement trackElement children size equals: 0
]

{ #category : #tests }
ToTabGroupElementTest >> testRemoveItem [

	| firstItem secondItem clicked |
	self withTwoTabItems.
	firstItem := tabGroup items first.
	secondItem := tabGroup items second.
	space deferAndSettle: [
		firstItem removable: true.
		secondItem removable: true  ].
	clicked := false.
	space deferAndSettle: [
		firstItem holder node addRemoveButton. 
		secondItem holder node addRemoveButton  ].
	secondItem removeButton
		addEventHandlerOn: BlClickEvent
		do: [ :evt | clicked := true ].
	self assert: tabGroup items size equals: 2.
	self assert: secondItem removeButton notNil.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	secondItem eventSimulator mouseMoveInside.
	secondItem removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: clicked.
	self assert: tabGroup items size equals: 1.
	self assert: tabGroup items first identicalTo: firstItem
]

{ #category : #tests }
ToTabGroupElementTest >> testRemoveItem2 [
	" same as #testRemoveItem but with selection of the second item before the removal.
	After the removing of the second item, the first should be selected "

	| firstItem secondItem |
	self withTwoTabItems.
	firstItem := tabGroup items first.
	secondItem := tabGroup items second.
	space deferAndSettle: [
		firstItem removable: true.
		secondItem removable: true.
		firstItem holder node addRemoveButton. 
		secondItem holder node addRemoveButton  ].
	secondItem eventSimulator
		mouseMoveInside;
		click.
	self assert: secondItem isSelected.
	" after the click, the remove button should be visible "
	secondItem eventSimulator mouseMoveInside.
	secondItem removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabGroup items size equals: 1.
	self assert: tabGroup items first identicalTo: firstItem.
	self assert: firstItem isSelected
]

{ #category : #tests }
ToTabGroupElementTest >> testRemoveItem3 [
	" same as #testRemoveItem2 but with selection of the first item (instead of the second one) before its removal.
	After the removing of the first item, the second is the unique items and it should remain selected "

	| firstItem secondItem |
	self withTwoTabItems.
	firstItem := tabGroup items first.
	secondItem := tabGroup items second.
	space deferAndSettle: [
		firstItem removable: true.
		secondItem removable: true.
		firstItem holder node addRemoveButton. 
		secondItem holder node addRemoveButton  ].
	firstItem eventSimulator
		mouseMoveInside;
		click.
	self assert: firstItem isSelected.
	" after the click, the remove button should be visible "
	firstItem eventSimulator mouseMoveInside.
	firstItem removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabGroup items size equals: 1.
	self assert: tabGroup items first identicalTo: secondItem.
	self assert: secondItem isSelected
]

{ #category : #tests }
ToTabGroupElementTest >> testRemoveItem4 [
	"second selected before, remove second button, first selected after "

	| firstItem secondItem |
	self withTwoTabItems.
	firstItem := tabGroup items first.
	secondItem := tabGroup items second.
	space deferAndSettle: [
		firstItem removable: true.
		secondItem removable: true.
		firstItem holder node addRemoveButton. 
		secondItem holder node addRemoveButton  ].
	secondItem eventSimulator
		mouseMoveInside;
		click.
	self deny: firstItem isSelected.
	self assert: secondItem isSelected.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	secondItem eventSimulator mouseMoveInside.
	secondItem removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabGroup items size equals: 1.
	self assert: tabGroup items first identicalTo: firstItem.
	self assert: firstItem isSelected
]

{ #category : #tests }
ToTabGroupElementTest >> testRemoveItem5 [
	"first selected before, remove first button, second selected after "

	| firstItem secondItem |
	self withTwoTabItems.
	firstItem := tabGroup items first.
	secondItem := tabGroup items second.
	space deferAndSettle: [
		firstItem removable: true.
		secondItem removable: true.
		firstItem holder node addRemoveButton. 
		secondItem holder node addRemoveButton  ].
	firstItem eventSimulator
		mouseMoveInside;
		click.
	self assert: firstItem isSelected.
	self deny: secondItem isSelected.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	firstItem eventSimulator mouseMoveInside.
	firstItem removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabGroup items size equals: 1.
	self assert: tabGroup items first identicalTo: secondItem.
	self assert: secondItem isSelected
]

{ #category : #tests }
ToTabGroupElementTest >> testRemoveItem6 [
	"first selected before, remove first button, second selected after "

	| firstItem secondItem |
	self withTwoTabItems.
	firstItem := tabGroup items first.
	secondItem := tabGroup items second.
	space deferAndSettle: [
		firstItem removable: true.
		secondItem removable: true.
		firstItem holder node addRemoveButton. 
		secondItem holder node addRemoveButton  ].
	firstItem eventSimulator
		mouseMoveInside;
		click.
	self assert: firstItem isSelected.
	self deny: secondItem isSelected.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	firstItem eventSimulator mouseMoveInside.
	firstItem removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabGroup items size equals: 1.
	self assert: tabGroup items first identicalTo: secondItem.
	self assert: secondItem isSelected.

	firstItem := tabGroup items first.
	firstItem eventSimulator mouseMoveInside.
	firstItem removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabGroup items size equals: 0.
	self assert: tabGroup itemList items size equals: 0.
	self assert: tabGroup itemList innerElement nodeContainers size equals: 0.
	" the fake node remains "
	self assert: tabGroup itemList innerElement trackElement children size equals: 0
]

{ #category : #tests }
ToTabGroupElementTest >> withTwoTabItems [

	space deferAndSettle: [
		tabGroup addItem:
			(ToTabItemElement new
				 id: #first;
				 labelText: 'First';
				 yourself).
		tabGroup addItem:
			(ToTabItemElement new
				 id: #second;
				 labelText: 'Second';
				 yourself) ]
]
