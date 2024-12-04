Class {
	#name : #ToTabPaneTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'notebook'
	],
	#category : #'Toplo-Widget-TabPane-Tests'
}

{ #category : #running }
ToTabPaneTest >> setUp [

	super setUp.
	notebook := ToTabPane new.
	space root addChild: notebook.
]

{ #category : #tests }
ToTabPaneTest >> testCloseLastPage [

	notebook addTabWithText: 'Red' builder: [ :pane :theNotebook |
		pane addChild: (BlElement new
				 background: Color red;
				 yourself) ].

	notebook lastTab closable: true.

	"self waitTestingSpaces."
	self assert: notebook tabs size equals: 1.
	self assert: notebook tabs last isSelected.

	self flag: 'Strange fix to make the test work'.
	notebook tabs last firstChild padding: BlInsets empty.
	notebook forceLayout.
	BlSpace simulateClickOn: notebook tabs last innerCloseButton.
	self waitTestingSpaces.
	space requestNextPulse.
	self assert: notebook tabs isEmpty
]

{ #category : #tests }
ToTabPaneTest >> testCloseSelectedPage [

	| redButton greenButton |
	notebook
		addTabWithText: 'Green'
		builder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color green;
					 yourself) ].
	greenButton := notebook lastTab.
	greenButton closable: true.
	
	notebook
		addTabWithText: 'Red'
		builder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color red;
					 yourself) ].
	redButton := notebook lastTab.
	redButton closable: true.
	
	"self waitTestingSpaces."
	self assert: (notebook  tabs includes: redButton ).
	self deny: redButton isSelected.
	
	self flag: 'Strange fix to make the test work'.

	notebook tabs do: [:t | t firstChild padding: BlInsets empty].
	notebook forceLayout.

	BlSpace simulateClickOn: redButton innerCloseButton.
	self waitTestingSpaces.
	self deny: (notebook tabs includes: redButton).
	self assert: greenButton isSelected.

]

{ #category : #tests }
ToTabPaneTest >> testCloseSelectedPage2 [

	| redButton greenButton |
	notebook
		addTabWithText: 'Red'
		builder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color red;
					 yourself) ].
	redButton := notebook lastTab.
	redButton closable: true.

	notebook
		addTabWithText: 'Green'
		builder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color green;
					 yourself) ].
	greenButton := notebook lastTab.
	greenButton closable: true.
	greenButton selected: true.
	
	self waitTestingSpaces.
	self applyAllEnqueuedStates.
	self assert: (notebook  tabs includes: redButton ).
	self assert: greenButton isSelected.

	BlSpace simulateClickOn: greenButton innerCloseButton.
	self waitTestingSpaces.
	self deny: (notebook tabs includes: greenButton)
]

{ #category : #tests }
ToTabPaneTest >> testCloseUnselectedPage [

	| redButton greenButton |
	notebook addTabWithText: 'Red' builder: [ :pane :theNotebook |
		pane addChild: (BlElement new
				 background: Color red;
				 yourself) ].
	redButton := notebook lastTab.
	redButton closable: true.
	redButton selected: true.

	notebook addTabWithText: 'Green' builder: [ :pane :theNotebook |
		pane addChild: (BlElement new
				 background: Color green;
				 yourself) ].
	greenButton := notebook lastTab.
	greenButton closable: true.

	self waitTestingSpaces.
	self assert: (notebook tabs includes: redButton).
	self assert: (notebook tabs includes: greenButton).
	self assert: redButton isSelected.
	self deny: greenButton isSelected.
	self applyAllEnqueuedStates.

	space class simulateClickOn: greenButton innerCloseButton.
	greenButton innerCloseButton addEventHandler: (BlEventHandler
			 on: BlEvent
			 do: [ :event | event traceCr ]).
	self waitTestingSpaces.
	space requestNextPulse.
	self deny: (notebook tabs includes: greenButton).
	self assert: (notebook tabs includes: redButton).
	self assert: redButton isSelected
]

{ #category : #tests }
ToTabPaneTest >> testCloseUnselectedPage2 [

	| redButton greenButton |
	notebook addTabWithText: 'Green' builder: [ :pane :theNotebook |
		pane addChild: (BlElement new
				 background: Color green;
				 yourself) ].
	greenButton := notebook lastTab.
	greenButton closable: true.

	notebook addTabWithText: 'Red' builder: [ :pane :theNotebook |
		pane addChild: (BlElement new
				 background: Color red;
				 yourself) ].
	redButton := notebook lastTab.
	redButton closable: true.
	redButton selected: true.

	self waitTestingSpaces.
	self assert: (notebook tabs includes: redButton).
	self assert: (notebook tabs includes: greenButton).
	self assert: redButton isSelected.
	self deny: greenButton isSelected.
	self applyAllEnqueuedStates.

	space class simulateClickOn: greenButton innerCloseButton.
	greenButton addEventHandler: (BlEventHandler
			 on: BlEvent
			 do: [ :event | event traceCr ]).
	self waitTestingSpaces.
	space requestNextPulse.
	self deny: (notebook tabs includes: greenButton).
	self assert: (notebook tabs includes: redButton).
	self assert: redButton isSelected
]

{ #category : #tests }
ToTabPaneTest >> testDefaultBodyIsTransparent [

	| aPage |
	aPage := notebook addTabWithText: 'Red'.

	self waitTestingSpaces.
	self assert: aPage body background isTransparent
]

{ #category : #tests }
ToTabPaneTest >> testIsSelected [

	| redButton greenButton |
	notebook
		addTabWithText: 'Red'
		builder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color red;
					 yourself) ].
	redButton := notebook lastTab.

	notebook
		addTabWithText: 'Green'
		builder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color green;
					 yourself) ].
	greenButton := notebook lastTab.
	
	self waitTestingSpaces.
	self assert: redButton isSelected.
	self deny: greenButton isSelected.

	BlSpace simulateClickOn: greenButton.
	self waitTestingSpaces.
	self assert: greenButton isSelected.
	self deny: redButton isSelected.

]

{ #category : #tests }
ToTabPaneTest >> testPaneBuilderIsValuedOnSelect [

	| redButton greenButton redCount greenCount |
	redCount := 0.
	notebook rebuildPaneOnSelect: true.
	notebook
		addTabWithText: 'Red'
		builder: [ :pane :theNotebook |
			redCount := redCount + 1.
			pane addChild: (BlElement new
					 background: Color red;
					 yourself) ].
	redButton := notebook lastTab.
	
	greenCount := 0.
	notebook
		addTabWithText: 'Green'
		builder: [ :pane :theNotebook |
			greenCount := greenCount + 1.
			pane addChild: (BlElement new
					 background: Color green;
					 yourself) ].
	greenButton := notebook lastTab.
	
	self waitTestingSpaces.
	self assert: redCount equals: 1.
	self assert: greenCount equals: 0.
	
	BlSpace simulateClickOn: greenButton.
	self waitTestingSpaces.
	self assert: redCount equals: 1.
	self assert: greenCount equals: 1.

	BlSpace simulateClickOn: redButton.
	self waitTestingSpaces.
	self assert: redCount equals: 2.
	self assert: greenCount equals: 1
]
