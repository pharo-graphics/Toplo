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

{ #category : #running }
ToTabGroupElementTest >> setUp [

	super setUp.
	tabGroup := ToTabGroupElement new.
	tabGroup matchParent.
	space root addChild: tabGroup.
	tabGroup forceLayout.
	self waitTestingSpaces 

]

{ #category : #tests }
ToTabGroupElementTest >> testIsSelected [

	| firstItem secondItem |
	self withTwoTabItems.
	firstItem := tabGroup items first.
	secondItem := tabGroup items second.

	self waitTestingSpaces.
	self deny: firstItem isSelected.
	self deny: secondItem isSelected.

	BlSpace simulateClickOn: secondItem.
	self waitTestingSpaces.
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
	firstButton removable: true.
	secondButton removable: true.
	self waitTestingSpaces.
	BlSpace simulateClickOn: firstButton.
	self waitTestingSpaces.
	self assert: firstButton isSelected.
	self deny: secondButton isSelected.
	tabGroup removeAllItems.
	self waitTestingSpaces.
	self assert: tabGroup items size equals: 0.
	self assert: tabGroup itemBar items size equals: 0.
	self assert: tabGroup itemBar innerElement nodeContainers size equals: 0.
	" the fake node remains "
	self assert: tabGroup itemBar innerElement trackElement children size equals: 0

]

{ #category : #tests }
ToTabGroupElementTest >> testRemoveItem [

	| firstItem secondItem clicked |
	self withTwoTabItems.
	firstItem := tabGroup items first.
	secondItem := tabGroup items second.
	firstItem removable: true.
	secondItem removable: true.
	tabGroup forceLayout.
	clicked := false.
	firstItem holder node addRemoveButton. 
	secondItem holder node  addRemoveButton. 
	self waitTestingSpacesTimeout: 400 milliSeconds.
	secondItem removeButton
		addEventHandlerOn: BlClickEvent
		do: [ :evt | clicked := true ].
	self assert: tabGroup items size equals: 2.
	self assert: secondItem removeButton notNil.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	BlSpace simulateMouseMoveInside: secondItem removeButton.
	BlSpace simulateClickOn: secondItem removeButton.
	self waitTestingSpacesTimeout: 600 milliSeconds.
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
	firstItem removable: true.
	secondItem removable: true.
	firstItem holder node addRemoveButton. 
	secondItem holder node  addRemoveButton. 
	self waitTestingSpaces.
	BlSpace simulateClickOn: secondItem.
	self waitTestingSpaces.
	self assert: secondItem isSelected.
	" after the click, the remove button should be visible "
	BlSpace simulateMouseMoveInside: secondItem removeButton.
	self waitTestingSpaces.
	BlSpace simulateClickOn: secondItem removeButton.
	self waitTestingSpaces.
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
	firstItem removable: true.
	secondItem removable: true.
	firstItem holder node addRemoveButton. 
	secondItem holder node  addRemoveButton. 
	self waitTestingSpaces.
	BlSpace simulateClickOn: firstItem.
	self waitTestingSpaces.
	self assert: firstItem isSelected.
	" after the click, the remove button should be visible "
	BlSpace simulateMouseMoveInside: firstItem removeButton.
	self waitTestingSpaces.
	BlSpace simulateClickOn: firstItem removeButton.
	self waitTestingSpaces.
	self assert: tabGroup items size equals: 1.
	self assert: tabGroup items first identicalTo: secondItem.
	self assert: secondItem isSelected.
]

{ #category : #tests }
ToTabGroupElementTest >> testRemoveItem4 [
	"second selected before, remove second button, first selected after "

	| firstItem secondItem |
	self withTwoTabItems.
	firstItem := tabGroup items first.
	secondItem := tabGroup items second.
	firstItem removable: true.
	secondItem removable: true.
	firstItem holder node addRemoveButton. 
	secondItem holder node  addRemoveButton. 
	self waitTestingSpaces.
	BlSpace simulateClickOn: secondItem.
	self waitTestingSpaces.
	self deny: firstItem isSelected.
	self assert: secondItem isSelected.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	BlSpace simulateMouseMoveInside: secondItem removeButton.
	BlSpace simulateClickOn: secondItem removeButton.
	self waitTestingSpaces.
	self assert: tabGroup items size equals: 1.
	self assert: tabGroup items first identicalTo: firstItem.
	self assert: firstItem isSelected.
]

{ #category : #tests }
ToTabGroupElementTest >> testRemoveItem5 [
	"first selected before, remove first button, second selected after "

	| firstItem secondItem |
	self withTwoTabItems.
	firstItem := tabGroup items first.
	secondItem := tabGroup items second.
	firstItem removable: true.
	secondItem removable: true.
	firstItem holder node addRemoveButton. 
	secondItem holder node  addRemoveButton. 
	self waitTestingSpaces.
	BlSpace simulateClickOn: firstItem.
	self waitTestingSpaces.
	self assert: firstItem isSelected.
	self deny: secondItem isSelected.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	BlSpace simulateMouseMoveInside: firstItem removeButton.
	BlSpace simulateClickOn: firstItem removeButton.
	self waitTestingSpaces.
	self assert: tabGroup items size equals: 1.
	self assert: tabGroup items first identicalTo: secondItem.
	self assert: secondItem isSelected.
]

{ #category : #tests }
ToTabGroupElementTest >> testRemoveItem6 [
	"first selected before, remove first button, second selected after "

	| firstItem secondItem |
	self withTwoTabItems.
	firstItem := tabGroup items first.
	secondItem := tabGroup items second.
	firstItem removable: true.
	secondItem removable: true.
	firstItem holder node addRemoveButton. 
	secondItem holder node  addRemoveButton. 
	self waitTestingSpaces.
	BlSpace simulateClickOn: firstItem.
	self waitTestingSpaces.
	self assert: firstItem isSelected.
	self deny: secondItem isSelected.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	BlSpace simulateMouseMoveInside: firstItem removeButton.
	BlSpace simulateClickOn: firstItem removeButton.
	self waitTestingSpaces.
	self assert: tabGroup items size equals: 1.
	self assert: tabGroup items first identicalTo: secondItem.
	self assert: secondItem isSelected.

	firstItem := tabGroup items first.
	BlSpace simulateMouseMoveInside: firstItem removeButton.
	BlSpace simulateClickOn: firstItem removeButton.
	self waitTestingSpaces.
	self assert: tabGroup items size equals: 0.
	self assert: tabGroup itemBar items size equals: 0.
	self assert: tabGroup itemBar innerElement nodeContainers size equals: 0.
	" the fake node remains "
	self assert: tabGroup itemBar innerElement trackElement children size equals: 0

]

{ #category : #tests }
ToTabGroupElementTest >> withTwoTabItems [

	tabGroup addItem: (ToTabItemElement new
			 id: #first;
			 labelText: 'First';
			 yourself).

	tabGroup addItem: (ToTabItemElement new
			 id: #second;
			 labelText: 'Second';
			 yourself).
	tabGroup forceLayout

]
