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
	tabPane horizontal: true.
	tabPane matchParent.
	space deferAndSettle: [ space root addChild: tabPane  ].
	tabPane eventSimulator mouseMoveInside.
	space settle
]

{ #category : #tests }
ToTabPaneElementTest >> testCheckTabButton [

	tabPane itemBuilder: [ :tabItem :data |
			tabItem
				id: data asSymbol;
				labelText: data asString;
				paneBuilder: [ :body :btn :holder |
						body addChild: (ToElement new
									 background: Color random;
									 matchParent;
									 yourself) ] ].

	space deferAndSettle: [ tabPane addTabItemData: 'First' ].
	self deny: tabPane items first isChecked.
	
	space deferAndSettle: [ tabPane items first checked: true ].
	self assert: tabPane items first isChecked
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseLastPage [

	| firstButton secondButton clicked |
	self withTwoTabButtons.

	firstButton := tabPane items first.
	secondButton := tabPane items second.
	space deferAndSettle: [
		firstButton removable: true.
		secondButton removable: true.
		firstButton holder node addRemoveButton. 
		secondButton holder node addRemoveButton ].

	clicked := false.
	secondButton removeButton
		addEventHandlerOn: BlClickEvent
		do: [ :evt | clicked := true ].
	self assert: tabPane items size equals: 2.
	self assert: secondButton removeButton notNil.

	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	secondButton eventSimulator mouseMoveInside.
	secondButton removeButton eventSimulator
		mouseMoveInside;
		click.
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
	space deferAndSettle: [
		firstButton removable: true.
		secondButton removable: true.
		firstButton holder node addRemoveButton. 
		secondButton holder node addRemoveButton ].

	secondButton eventSimulator
		mouseMoveInside;
		click.
	self assert: secondButton isSelected.

	" after the click, the remove button should be visible "
	secondButton eventSimulator mouseMoveInside.
	secondButton removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: firstButton.
	self assert: firstButton isSelected
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseSelectedPage2 [

	| firstButton secondButton |
	self withTwoTabButtons.

	firstButton := tabPane items first.
	secondButton := tabPane items second.
	space deferAndSettle: [
		firstButton removable: true.
		secondButton removable: true.
		firstButton holder node addRemoveButton. 
		secondButton holder node addRemoveButton ].

	firstButton eventSimulator
		mouseMoveInside;
		click.
	self assert: firstButton isSelected.

	" after the click, the remove button should be visible "
	firstButton eventSimulator mouseMoveInside.
	firstButton removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: secondButton.
	self assert: secondButton isSelected
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseUnselectedPage [
	" no button selected before, no button selected after "

	| firstButton secondButton clicked |
	self withTwoTabButtons.

	firstButton := tabPane items first.
	clicked := false.
	secondButton := tabPane items second.
	space deferAndSettle: [
		firstButton removable: true.
		secondButton removable: true.
		firstButton holder node addRemoveButton. 
		secondButton holder node addRemoveButton ].

	firstButton removeButton
		addEventHandlerOn: BlClickEvent
		do: [ :evt | clicked := true ].
	firstButton eventSimulator mouseMoveInside.
	self deny: firstButton isSelected.
	self deny: secondButton isSelected.

	" after the click, the remove button should be visible "
	firstButton eventSimulator mouseMoveInside.
	firstButton removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: clicked.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: secondButton.
	self deny: secondButton isSelected
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseUnselectedPage2 [
	"first selected before, remove second button, first selected after "

	| firstButton secondButton |
	self withTwoTabButtons.

	firstButton := tabPane items first.
	secondButton := tabPane items second.
	space deferAndSettle: [
		firstButton removable: true.
		secondButton removable: true.
		firstButton holder node addRemoveButton. 
		secondButton holder node addRemoveButton ].

	firstButton eventSimulator
		mouseMoveInside;
		click.
	self assert: firstButton isSelected.
	self deny: secondButton isSelected.

	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	secondButton eventSimulator mouseMoveInside.
	secondButton removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: firstButton.
	self assert: firstButton isSelected
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseUnselectedPage3 [
	"second selected before, remove second button, first selected after "

	| firstButton secondButton |
	self withTwoTabButtons.

	firstButton := tabPane items first.
	secondButton := tabPane items second.
	space deferAndSettle: [
		firstButton removable: true.
		secondButton removable: true.
		firstButton holder node addRemoveButton. 
		secondButton holder node addRemoveButton ].

	secondButton eventSimulator
		mouseMoveInside;
		click.
	self deny: firstButton isSelected.
	self assert: secondButton isSelected.

	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	secondButton eventSimulator mouseMoveInside.
	secondButton removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: firstButton.
	self assert: firstButton isSelected
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseUnselectedPage4 [
	"first selected before, remove first button, second selected after "

	| firstButton secondButton |
	self withTwoTabButtons.

	firstButton := tabPane items first.
	secondButton := tabPane items second.
	space deferAndSettle: [
		firstButton removable: true.
		secondButton removable: true.
		firstButton holder node addRemoveButton. 
		secondButton holder node addRemoveButton ].

	firstButton eventSimulator
		mouseMoveInside;
		click.
	self assert: firstButton isSelected.
	self deny: secondButton isSelected.

	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	firstButton eventSimulator mouseMoveInside.
	firstButton removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: secondButton.
	self assert: secondButton isSelected
]

{ #category : #tests }
ToTabPaneElementTest >> testCloseUnselectedPage5 [
	"first selected before, remove first button, second selected after "

	| firstButton secondButton |
	self withTwoTabButtons.

	firstButton := tabPane items first.
	secondButton := tabPane items second.
	space deferAndSettle: [
		firstButton removable: true.
		secondButton removable: true.
		firstButton holder node addRemoveButton. 
		secondButton holder node addRemoveButton ].

	firstButton eventSimulator
		mouseMoveInside;
		click.
	self assert: firstButton isSelected.
	self deny: secondButton isSelected.
	" one have first to ensure that the remove button is visible 
	(with Raw skin, the remove button is only visible when the mouse is over its tab button) "
	firstButton eventSimulator mouseMoveInside.
	firstButton removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabPane items size equals: 1.
	self assert: tabPane items first identicalTo: secondButton.
	self assert: secondButton isSelected.

	firstButton := tabPane items first.
	firstButton eventSimulator mouseMoveInside.
	firstButton removeButton eventSimulator
		mouseMoveInside;
		click.
	self assert: tabPane items size equals: 0.
	self assert: tabPane body children isEmpty
]

{ #category : #tests }
ToTabPaneElementTest >> testIsSelected [

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.

	self deny: firstButton isSelected.
	self deny: secondButton isSelected.

	secondButton eventSimulator click.
	self assert: secondButton isSelected.
	self deny: firstButton isSelected
]

{ #category : #tests }
ToTabPaneElementTest >> testPaneBuilderIsValuedOnSelect [

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.
	
	self assert: firstTabBuildCount equals: 0.
	self assert: secondTabBuildCount equals: 0.
	
	secondButton eventSimulator click.
	self assert: firstTabBuildCount equals: 0.
	self assert: secondTabBuildCount equals: 1.

	firstButton eventSimulator click.
	self assert: firstTabBuildCount equals: 1.
	self assert: secondTabBuildCount equals: 1.

	secondButton eventSimulator click.
	self assert: firstTabBuildCount equals: 1.
	self assert: secondTabBuildCount equals: 1.

	firstButton eventSimulator click.
	self assert: firstTabBuildCount equals: 1.
	self assert: secondTabBuildCount equals: 1
]

{ #category : #tests }
ToTabPaneElementTest >> testPaneBuilderIsValuedOnSelect2 [ 

	| firstButton secondButton |
	self withTwoTabButtons.
	firstButton := tabPane items first.
	secondButton := tabPane items second.
	space deferAndSettle: [
		firstButton destroyPaneWhenDeselected: true.
		secondButton destroyPaneWhenDeselected: true ].
	
	secondButton eventSimulator click.

	firstButton eventSimulator click.

	secondButton eventSimulator click.

	self assert: firstTabBuildCount equals: 1.
	self assert: secondTabBuildCount equals: 2.

	firstButton eventSimulator click.

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
	space deferAndSettle: [
		firstButton removable: true.
		secondButton removable: true ].

	firstButton eventSimulator click.
	self assert: firstButton isSelected.
	self deny: secondButton isSelected.
	self assert: tabPane body children notEmpty.

	space deferAndSettle: [ tabPane removeAllItems ].
	self assert: tabPane items size equals: 0.
	self assert: tabPane body children isEmpty
]

{ #category : #tests }
ToTabPaneElementTest >> testSelectTabButton [

	tabPane itemBuilder: [ :tabItem :data |
			tabItem
				id: data asSymbol;
				labelText: data asString;
				paneBuilder: [ :body :btn :holder |
						body addChild: (ToElement new
									 background: Color random;
									 matchParent;
									 yourself) ] ].

	space deferAndSettle: [ tabPane addTabItemData: 'First' ].
	self deny: tabPane items first isChecked.

	space deferAndSettle: [ tabPane selecter selectIndex: 1 ].
	self assert: tabPane items first isChecked
]

{ #category : #tests }
ToTabPaneElementTest >> withTwoTabButtons [

	space deferAndSettle: [
		tabPane addItem:
			(ToTabButton new
				 id: #first;
				 labelText: 'First';
				 paneBuilder: [ :body :btn :holder |
					 firstTabBuildCount := firstTabBuildCount + 1.
					 body addChild:
						(ToElement new
							background: Color red;
							matchParent;
							yourself) ];
				 yourself).

		tabPane addItem:
			(ToTabButton new
				 id: #second;
				 labelText: 'Second';
				 paneBuilder: [ :body :btn :holder |
						secondTabBuildCount := secondTabBuildCount + 1.
						body addChild:
							(ToElement new
								background: Color green;
								matchParent;
								yourself) ];
				 yourself) ]
]
