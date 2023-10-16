Class {
	#name : 'ToNotebookTest',
	#superclass : 'BlParameterizedHostTest',
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
ToNotebookTest >> testBodyFactoryIsValuedOnSelect [

	| redPage greenPage redCount greenCount |
	redCount := 0.
	redPage := notebook
		addPageTitle: 'Red'
		bodyBuilder: [
			redCount := redCount + 1.
			BlTextElement new
				text: (redCount asRopedText foreground: Color red darker);
				yourself ].

	greenCount := 0.
	greenPage := notebook
		addPageTitle: 'Green'
		bodyBuilder: [
			greenCount := greenCount + 1.
			BlTextElement new
				text: (greenCount asRopedText foreground: Color green muchDarker);
				yourself ].
	
	self waitTestingSpaces.
	self assert: redCount equals: 1.
	self assert: greenCount equals: 0.
	
	BlSpace simulateClickOn: greenPage titleElement.
	self waitTestingSpaces.
	self assert: redCount equals: 1.
	self assert: greenCount equals: 1.

	BlSpace simulateClickOn: redPage titleElement.
	self waitTestingSpaces.
	self assert: redCount equals: 2.
	self assert: greenCount equals: 1
]

{ #category : 'tests' }
ToNotebookTest >> testCloseLastPage [

	| redPage |
	redPage := notebook
		addPageTitle: 'Red'
		body: (BlElement new
			background: Color red;
			yourself).
	redPage isCloseable: true.
	
	self waitTestingSpaces.
	self assert: (notebook pages includes: redPage).
	self assert: redPage isSelected.

	BlSpace simulateClickOn: redPage closeButton.
	self waitTestingSpaces.
	self assert: notebook pages isEmpty.

]

{ #category : 'tests' }
ToNotebookTest >> testCloseSelectedPage [

	| redPage greenPage |
	redPage := notebook
		addPageTitle: 'Red'
		body: (BlElement new
			background: Color red;
			yourself).
	redPage isCloseable: true.

	greenPage := notebook
		addPageTitle: 'Green'
		body: (BlElement new
			background: Color green;
			yourself).
	
	self waitTestingSpaces.
	self assert: (notebook pages includes: redPage).
	self assert: redPage isSelected.

	BlSpace simulateClickOn: redPage closeButton.
	self waitTestingSpaces.
	self deny: (notebook pages includes: redPage).
	self assert: greenPage isSelected.

]

{ #category : 'tests' }
ToNotebookTest >> testCloseUnselectedPage [

	| redPage greenPage |
	redPage := notebook
		addPageTitle: 'Red'
		body: (BlElement new
			background: Color red;
			yourself).
	redPage isCloseable: true.

	greenPage := notebook
		addPageTitle: 'Green'
		body: (BlElement new
			background: Color green;
			yourself).
	greenPage isCloseable: true.
	
	self waitTestingSpaces.
	self assert: (notebook pages includes: redPage).
	self assert: redPage isSelected.

	BlSpace simulateClickOn: greenPage closeButton.
	self waitTestingSpaces.
	self deny: (notebook pages includes: greenPage).
	self assert: redPage isSelected.

]

{ #category : 'tests' }
ToNotebookTest >> testDefaultBodyIsTransparent [

	| aPage |
	aPage := notebook addPageTitle: '1'.

	self waitTestingSpaces.
	self assert: aPage bodyElement background isTransparent
]

{ #category : 'tests' }
ToNotebookTest >> testSelectPage [

	| orangePage greenPage |
	orangePage := notebook
		addPageTitle: 'Orange'
		body: (BlElement new
			background: Color orange;
			yourself).
	greenPage := notebook
		addPageTitle: 'Green'
		body: (BlElement new
			background: Color green;
			yourself).
	
	self waitTestingSpaces.
	self assert: orangePage isSelected.
	self deny: greenPage isSelected.

	BlSpace simulateClickOn: greenPage titleElement.
	self waitTestingSpaces.
	self assert: greenPage isSelected.
	self deny: orangePage isSelected.

]
