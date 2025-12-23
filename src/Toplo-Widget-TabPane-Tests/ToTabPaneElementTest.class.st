"
A ToTabPaneElementTest is a test class for testing the behavior of ToTabPaneElement
"
Class {
	#name : #ToTabPaneElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'tabPane',
		'firstTabBuildCount',
		'secondTabBuildCount'
	],
	#category : #'Toplo-Widget-TabPane-Tests-TabPane'
}

{ #category : #running }
ToTabPaneElementTest >> setUp [

	super setUp.
	firstTabBuildCount := 0.
	secondTabBuildCount := 0.
	tabPane := ToTabPaneElement new.
	tabPane matchParent.
	space root addChild: tabPane.
	tabPane forceLayout.
	BlSpace simulateMouseMoveInside: tabPane.
	self waitTestingSpaces 
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseLastPage [

	| firstButton secondButton clicked |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.
	firstButton removable: true.
	secondButton removable: true.
	firstButton holder node addRemoveButton. 
	secondButton holder node  addRemoveButton. 
	tabPane forceLayout.
	clicked := false.
	self waitTestingSpacesTimeout: 400 milliSeconds.
	secondButton removeButton
		addEventHandlerOn: BlClickEvent
		do: [ :evt | clicked := true ].
	self assert: tabPane items size equals: 2.
	self assert: secondButton removeButton notNil.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	BlSpace simulateMouseMoveInside: secondButton removeButton.
	BlSpace simulateClickOn: secondButton removeButton.
	self waitTestingSpacesTimeout: 600 milliSeconds.
	self assert: clicked.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: firstButton
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseSelectedPage [

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.
	firstButton removable: true.
	secondButton removable: true.
	firstButton holder node addRemoveButton. 
	secondButton holder node  addRemoveButton. 
	self waitTestingSpaces.
	BlSpace simulateClickOn: secondButton.
	self waitTestingSpaces.
	self assert: secondButton isSelected.
	" after the click, the remove button should be visible "
	BlSpace simulateMouseMoveInside: secondButton removeButton.
	self waitTestingSpaces.
	BlSpace simulateClickOn: secondButton removeButton.
	self waitTestingSpaces.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: firstButton.
	self assert: firstButton isSelected.
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseSelectedPage2 [

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.
	firstButton removable: true.
	secondButton removable: true.
	firstButton holder node addRemoveButton. 
	secondButton holder node  addRemoveButton. 
	self waitTestingSpaces.
	BlSpace simulateClickOn: firstButton.
	self waitTestingSpaces.
	self assert: firstButton isSelected.
	" after the click, the remove button should be visible "
	BlSpace simulateMouseMoveInside: firstButton removeButton.
	self waitTestingSpaces.
	BlSpace simulateClickOn: firstButton removeButton.
	self waitTestingSpaces.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: secondButton.
	self assert: secondButton isSelected.
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseUnselectedPage [
	" no button selected before, no button selected after "

	| firstButton secondButton clicked |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	clicked := false.
	secondButton := tabPane items second.
	firstButton removable: true.
	secondButton removable: true.
	firstButton holder node addRemoveButton. 
	secondButton holder node  addRemoveButton. 
	tabPane forceLayout.
	self waitTestingSpacesTimeout: 400 milliSeconds.
	firstButton removeButton addEventHandlerOn: BlClickEvent do: [ :evt | clicked := true ].
	BlSpace simulateMouseMoveInside: firstButton.
	self waitTestingSpacesTimeout: 400 milliSeconds.
	self deny: firstButton isSelected.
	self deny: secondButton isSelected.
	" after the click, the remove button should be visible "
	BlSpace simulateMouseMoveInside: firstButton removeButton.
	BlSpace simulateClickOn: firstButton removeButton.
	self waitTestingSpacesTimeout: 400 milliSeconds.
	self assert: clicked.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: secondButton.
	self deny: secondButton isSelected.
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseUnselectedPage2 [
	"first selected before, remove second button, first selected after "

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.
	firstButton removable: true.
	secondButton removable: true.
	firstButton holder node addRemoveButton. 
	secondButton holder node  addRemoveButton. 
	self waitTestingSpaces.
	BlSpace simulateClickOn: firstButton.
	self waitTestingSpaces.
	self assert: firstButton isSelected.
	self deny: secondButton isSelected.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	BlSpace simulateMouseMoveInside: secondButton removeButton.
	BlSpace simulateClickOn: secondButton removeButton.
	self waitTestingSpaces.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: firstButton.
	self assert: firstButton isSelected.
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseUnselectedPage3 [
	"second selected before, remove second button, first selected after "

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.
	firstButton removable: true.
	secondButton removable: true.
	firstButton holder node addRemoveButton. 
	secondButton holder node  addRemoveButton. 
	self waitTestingSpaces.
	BlSpace simulateClickOn: secondButton.
	self waitTestingSpaces.
	self deny: firstButton isSelected.
	self assert: secondButton isSelected.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	BlSpace simulateMouseMoveInside: secondButton removeButton.
	BlSpace simulateClickOn: secondButton removeButton.
	self waitTestingSpaces.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: firstButton.
	self assert: firstButton isSelected.
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseUnselectedPage4 [
	"first selected before, remove first button, second selected after "

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.
	firstButton removable: true.
	secondButton removable: true.
	firstButton holder node addRemoveButton. 
	secondButton holder node  addRemoveButton. 
	self waitTestingSpaces.
	BlSpace simulateClickOn: firstButton.
	self waitTestingSpaces.
	self assert: firstButton isSelected.
	self deny: secondButton isSelected.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	BlSpace simulateMouseMoveInside: firstButton removeButton.
	BlSpace simulateClickOn: firstButton removeButton.
	self waitTestingSpaces.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: secondButton.
	self assert: secondButton isSelected.
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseUnselectedPage5 [
	"first selected before, remove first button, second selected after "

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.
	firstButton removable: true.
	secondButton removable: true.
	firstButton holder node addRemoveButton. 
	secondButton holder node  addRemoveButton. 
	self waitTestingSpaces.
	BlSpace simulateClickOn: firstButton.
	self waitTestingSpaces.
	self assert: firstButton isSelected.
	self deny: secondButton isSelected.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	BlSpace simulateMouseMoveInside: firstButton removeButton.
	BlSpace simulateClickOn: firstButton removeButton.
	self waitTestingSpaces.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: secondButton.
	self assert: secondButton isSelected.

	firstButton := tabPane items first.
	BlSpace simulateMouseMoveInside: firstButton removeButton.
	BlSpace simulateClickOn: firstButton removeButton.
	self waitTestingSpaces.
	self assert: tabPane items size equals: 0.
	self assert: tabPane body children isEmpty
]

{ #category : #tests }
ToTabPaneElementTest >> testIsSelected [

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.

	self waitTestingSpaces.
	self deny: firstButton isSelected.
	self deny: secondButton isSelected.

	BlSpace simulateClickOn: secondButton.
	self waitTestingSpaces.
	self assert: secondButton isSelected.
	self deny: firstButton isSelected
]

{ #category : #tests }
ToTabPaneElementTest >> testPaneBuilderIsValuedOnSelect [

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.
	
	self waitTestingSpaces.
	self assert: firstTabBuildCount equals: 0.
	self assert: secondTabBuildCount equals: 0.
	
	BlSpace simulateClickOn: secondButton.
	self waitTestingSpaces.
	self assert: firstTabBuildCount equals: 0.
	self assert: secondTabBuildCount equals: 1.

	BlSpace simulateClickOn: firstButton.
	self waitTestingSpaces.
	self assert: firstTabBuildCount equals: 1.
	self assert: secondTabBuildCount equals: 1.

	BlSpace simulateClickOn: secondButton.
	self waitTestingSpaces.
	self assert: firstTabBuildCount equals: 1.
	self assert: secondTabBuildCount equals: 1.

	BlSpace simulateClickOn: firstButton.
	self waitTestingSpaces.
	self assert: firstTabBuildCount equals: 1.
	self assert: secondTabBuildCount equals: 1
]

{ #category : #tests }
ToTabPaneElementTest >> testPaneBuilderIsValuedOnSelect2 [ 

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.
	firstButton destroyPaneWhenDeselected: true.
	secondButton destroyPaneWhenDeselected: true.
	
	self waitTestingSpaces.
	
	BlSpace simulateClickOn: secondButton.
	self waitTestingSpaces.

	BlSpace simulateClickOn: firstButton.
	self waitTestingSpaces.

	BlSpace simulateClickOn: secondButton.
	self waitTestingSpaces.
	self assert: firstTabBuildCount equals: 1.
	self assert: secondTabBuildCount equals: 2.

	BlSpace simulateClickOn: firstButton.
	self waitTestingSpaces.
	self assert: firstTabBuildCount equals: 2.
	self assert: secondTabBuildCount equals: 2
]

{ #category : #tests }
ToTabPaneElementTest >> testRemoveAllItems [
	"first selected before, remove first button, second selected after "

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.
	firstButton removable: true.
	secondButton removable: true.
	self waitTestingSpaces.
	BlSpace simulateClickOn: firstButton.
	self waitTestingSpaces.
	self assert: firstButton isSelected.
	self deny: secondButton isSelected.
	self assert: tabPane body children notEmpty.
	tabPane removeAllItems.
	self waitTestingSpaces.
	self assert: tabPane items size equals: 0.
	self assert: tabPane body children isEmpty.


]

{ #category : #tests }
ToTabPaneElementTest >> withTwoTabButtons [

	tabPane addItem: (ToTabButton new
			 id: #first;
			 labelText: 'First';
			 paneBuilder: [ :body :btn :holder |
					 firstTabBuildCount := firstTabBuildCount + 1.
					 body addChild: (ToElement new
								  background: Color red;
								  matchParent;
								  yourself) ];
			 yourself).

	tabPane addItem: (ToTabButton new
			 id: #second;
			 labelText: 'Second';
			 paneBuilder: [ :body :btn :holder |
					 secondTabBuildCount := secondTabBuildCount + 1.
					 body addChild: (ToElement new
								  background: Color green;
								  matchParent;
								  yourself) ];
			 yourself)
]
