Class {
	#name : #ToNotebookTest,
	#superclass : #BlParameterizedTest,
	#category : #'Toplo-Tests-Widget-Notebook'
}

{ #category : #tests }
ToNotebookTest >> testBodyFactoryIsValuedOnSelect [

	| aNotebook redPage greenPage redCount greenCount |
	aNotebook := ToNotebook new.

	redCount := 0.
	redPage := aNotebook
		addPageTitle: 'Red'
		bodyFactory: [
			redCount := redCount + 1.
			BlTextElement new
				text: (redCount asRopedText foreground: Color red darker);
				yourself ].

	greenCount := 0.
	greenPage := aNotebook
		addPageTitle: 'Green'
		bodyFactory: [
			greenCount := greenCount + 1.
			BlTextElement new
				text: (greenCount asRopedText foreground: Color green muchDarker);
				yourself ].
	
	self newTestingSpace root addChild: aNotebook.
	self newTestingSpace show.
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

{ #category : #tests }
ToNotebookTest >> testClosePage [

	| aNotebook redPage greenPage |
	aNotebook := ToNotebook new.
	
	redPage := aNotebook
		addPageTitle: 'Red'
		body: (BlElement new
			background: Color red darker;
			yourself).
	redPage isCloseable: true.

	greenPage := aNotebook
		addPageTitle: 'Green'
		body: (BlElement new
			background: Color green darker;
			yourself).
	
	self newTestingSpace root addChild: aNotebook.
	self newTestingSpace show.
	self waitTestingSpaces.
	self assert: (aNotebook pages includes: redPage).

	BlSpace simulateClickOn: redPage closeButton.
	self waitTestingSpaces.
	self deny: (aNotebook pages includes: redPage).
	self assert: greenPage isSelected.

]

{ #category : #tests }
ToNotebookTest >> testDefaultBodyIsTransparent [

	| aNotebook aPage |
	aNotebook := ToNotebook new.
	aPage := aNotebook addPageTitle: '1'.

	self newTestingSpace root addChild: aNotebook.
	self newTestingSpace show.
	self waitTestingSpaces.

	self assert: aPage bodyElement background isTransparent
]

{ #category : #tests }
ToNotebookTest >> testSelectPage [

	| aNotebook orangePage greenPage |
	aNotebook := ToNotebook new.
	
	orangePage := aNotebook
		addPageTitle: 'Orange'
		body: (BlElement new
			background: Color orange darker;
			yourself).
	greenPage := aNotebook
		addPageTitle: 'Green'
		body: (BlElement new
			background: Color green darker;
			yourself).
	
	self newTestingSpace root addChild: aNotebook.
	self newTestingSpace show.
	self waitTestingSpaces.
	self assert: orangePage isSelected.
	self deny: greenPage isSelected.

	BlSpace simulateClickOn: greenPage titleElement.
	self waitTestingSpaces.
	self assert: greenPage isSelected.
	self deny: orangePage isSelected.

]
