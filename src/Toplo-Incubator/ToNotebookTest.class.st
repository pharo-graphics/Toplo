Class {
	#name : 'ToNotebookTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'notebook'
	],
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'running' }
ToNotebookTest >> setUp [

	| space |
	super setUp.

	space := self newTestingSpace.
	notebook := ToNotebook new.
	space root addChild: notebook.
]

{ #category : 'tests' }
ToNotebookTest >> testCloseLastPage [

	notebook
		addButtonWithText: 'Red'
		withPaneBuilder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color red;
					 yourself) ].

	notebook lastButton closable: true.

	self waitTestingSpaces.
	self assert: notebook buttons size = 1.
	self assert: notebook buttons last isSelected.

	BlSpace simulateClickOn: notebook buttons last innerCloseButton.
	self waitTestingSpaces.
	self assert: notebook buttons isEmpty
]

{ #category : 'tests' }
ToNotebookTest >> testCloseSelectedPage [

	| redButton greenButton |
	notebook
		addButtonWithText: 'Red'
		withPaneBuilder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color red;
					 yourself) ].
	redButton := notebook lastButton.
	redButton closable: true.

	notebook
		addButtonWithText: 'Green'
		withPaneBuilder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color green;
					 yourself) ].
	greenButton := notebook lastButton.
	
	self waitTestingSpaces.
	self assert: (notebook  buttons includes: redButton ).
	self assert: redButton isSelected.

	BlSpace simulateClickOn: redButton innerCloseButton.
	self waitTestingSpaces.
	self deny: (notebook buttons includes: redButton).
	self assert: greenButton isSelected.

]

{ #category : 'tests' }
ToNotebookTest >> testCloseUnselectedPage [

	| redButton greenButton |
	notebook
		addButtonWithText: 'Red'
		withPaneBuilder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color red;
					 yourself) ].
	redButton := notebook lastButton.
	redButton closable: true.
	redButton selected: true.

	notebook
		addButtonWithText: 'Green'
		withPaneBuilder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color green;
					 yourself) ].
	greenButton := notebook lastButton.
	greenButton closable: true.
	
	self waitTestingSpaces.
	self assert: (notebook buttons includes: redButton).
	self assert: redButton isSelected.

	BlSpace simulateClickOn: greenButton innerCloseButton.
	self waitTestingSpaces.
	self deny: (notebook buttons includes: greenButton).
	self assert: redButton isSelected.
]

{ #category : 'tests' }
ToNotebookTest >> testDefaultBodyIsTransparent [

	| aPage |
	aPage := notebook addButtonWithText: 'Red'.

	self waitTestingSpaces.
	self assert: aPage body background isTransparent
]

{ #category : 'tests' }
ToNotebookTest >> testIsSelected [

	| redButton greenButton |
	notebook
		addButtonWithText: 'Red'
		withPaneBuilder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color red;
					 yourself) ].
	redButton := notebook lastButton.

	notebook
		addButtonWithText: 'Green'
		withPaneBuilder: [ :pane :theNotebook |
			pane addChild: (BlElement new
					 background: Color green;
					 yourself) ].
	greenButton := notebook lastButton.
	
	self waitTestingSpaces.
	self assert: redButton isSelected.
	self deny: greenButton isSelected.

	BlSpace simulateClickOn: greenButton.
	self waitTestingSpaces.
	self assert: greenButton isSelected.
	self deny: redButton isSelected.

]

{ #category : 'tests' }
ToNotebookTest >> testPaneBuilderIsValuedOnSelect [

	| redButton greenButton redCount greenCount |
	redCount := 0.
	notebook rebuildPaneOnSelect: true.
	notebook
		addButtonWithText: 'Red'
		withPaneBuilder: [ :pane :theNotebook |
			redCount := redCount + 1.
			pane addChild: (BlElement new
					 background: Color red;
					 yourself) ].
	redButton := notebook lastButton.
	
	greenCount := 0.
	notebook
		addButtonWithText: 'Green'
		withPaneBuilder: [ :pane :theNotebook |
			greenCount := greenCount + 1.
			pane addChild: (BlElement new
					 background: Color green;
					 yourself) ].
	greenButton := notebook lastButton.
	
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
