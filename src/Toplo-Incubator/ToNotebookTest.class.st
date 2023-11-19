Class {
	#name : #ToNotebookTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'notebook'
	],
	#category : 'Toplo-Incubator'
}

{ #category : #running }
ToNotebookTest >> setUp [

	| space |
	super setUp.

	space := self newTestingSpace.
	notebook := ToNotebook new.
	space root addChild: notebook.
]

{ #category : #tests }
ToNotebookTest >> testCloseLastPage [

	| redPage |
	redPage := notebook
		addPageEntitled: 'Red'
		withBody: (BlElement new
			background: Color red;
			yourself).
	redPage closable: true.
	
	self waitTestingSpaces.
	self assert: (notebook pages buttons includes: redPage).
	self assert: redPage isSelected.

	BlSpace simulateClickOn: redPage innerCloseButton.
	self waitTestingSpaces.
	self assert: notebook pages buttons isEmpty.

]

{ #category : #tests }
ToNotebookTest >> testCloseSelectedPage [

	| redPage greenPage |
	redPage := notebook
		addPageEntitled: 'Red'
		withBody: (BlElement new
			background: Color red;
			yourself).
	redPage closable: true.

	greenPage := notebook
		addPageEntitled: 'Green'
		withBody: (BlElement new
			background: Color green;
			yourself).
	
	self waitTestingSpaces.
	self assert: (notebook pages buttons includes: redPage).
	self assert: redPage isSelected.

	BlSpace simulateClickOn: redPage innerCloseButton.
	self waitTestingSpaces.
	self deny: (notebook pages buttons includes: redPage).
	self assert: greenPage isSelected.

]

{ #category : #tests }
ToNotebookTest >> testCloseUnselectedPage [

	| redPage greenPage |
	redPage := notebook
		addPageEntitled: 'Red'
		withBody: (BlElement new
			background: Color red;
			yourself).
	redPage closable: true.
	redPage selected: true.

	greenPage := notebook
		addPageEntitled: 'Green'
		withBody: (BlElement new
			background: Color green;
			yourself).
	greenPage closable: true.
	
	self waitTestingSpaces.
	self assert: (notebook pages buttons includes: redPage).
	self assert: redPage isSelected.

	BlSpace simulateClickOn: greenPage innerCloseButton.
	self waitTestingSpaces.
	self deny: (notebook pages buttons includes: greenPage).
	self assert: redPage isSelected.

]

{ #category : #tests }
ToNotebookTest >> testDefaultBodyIsTransparent [

	| aPage |
	aPage := notebook addPageEntitled: '1'.

	self waitTestingSpaces.
	self assert: aPage bodyElement background isTransparent
]

{ #category : #tests }
ToNotebookTest >> testIsSelected [

	| orangePage greenPage |
	orangePage := notebook
		addPageEntitled: 'Orange'
		withBody: (BlElement new
			background: Color orange;
			yourself).
	greenPage := notebook
		addPageEntitled: 'Green'
		withBody: (BlElement new
			background: Color green;
			yourself).
	
	self waitTestingSpaces.
	self assert: orangePage isSelected.
	self deny: greenPage isSelected.

	BlSpace simulateClickOn: greenPage button.
	self waitTestingSpaces.
	self assert: greenPage isSelected.
	self deny: orangePage isSelected.

]

{ #category : #tests }
ToNotebookTest >> testPaneBuilderIsValuedOnSelect [

	| redPage greenPage redCount greenCount |
	redCount := 0.
	redPage := notebook
		addPageEntitled: 'Red'
		withBodyBuilder: [
			redCount := redCount + 1.
			BlTextElement new
				text: (redCount asRopedText foreground: Color red darker);
				yourself ].

	greenCount := 0.
	greenPage := notebook
		addPageEntitled: 'Green'
		withBodyBuilder: [
			greenCount := greenCount + 1.
			BlTextElement new
				text: (greenCount asRopedText foreground: Color green muchDarker);
				yourself ].
	
	self waitTestingSpaces.
	self assert: redCount equals: 1.
	self assert: greenCount equals: 0.
	
	BlSpace simulateClickOn: greenPage button.
	self waitTestingSpaces.
	self assert: redCount equals: 1.
	self assert: greenCount equals: 1.

	BlSpace simulateClickOn: redPage button.
	self waitTestingSpaces.
	self assert: redCount equals: 2.
	self assert: greenCount equals: 1
]
