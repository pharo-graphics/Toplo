Class {
	#name : #ToNotebookTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'testingSpaces',
		'hostClass'
	],
	#category : #'Toplo-Tests-Widget-Notebook'
}

{ #category : #tests }
ToNotebookTest class >> testParameters [

	^ ParametrizedTestMatrix new
		forSelector: #hostClass
		addOptions: {
		   BlMockedHost.
			BlOSWindowSDL2Host.
		   BlMorphicWindowHost }
]

{ #category : #accessing }
ToNotebookTest >> hostClass [

	^ hostClass
]

{ #category : #accessing }
ToNotebookTest >> hostClass: aClass [

	hostClass := aClass
]

{ #category : #'instance creation' }
ToNotebookTest >> newTestingSpace [

	| aSpace |
	aSpace := OBlSpace new.
	aSpace host: hostClass new.
	testingSpaces add: aSpace.
	^ aSpace
]

{ #category : #initialization }
ToNotebookTest >> setUp [
	super setUp.

	testingSpaces := OrderedCollection new.
]

{ #category : #running }
ToNotebookTest >> tearDown [

	self waitTestingSpaces.
	testingSpaces do: [ :each | each close ].
	self waitTestingSpaces.
	
	super tearDown.

]

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
	
	self newTestingSpace root addChild: aNotebook; show.
	self waitTestingSpaces.
	self assert: redCount equals: 1.
	self assert: greenCount equals: 0.
	
	OBlSpace simulateClickOn: greenPage titleElement.
	self waitTestingSpaces.
	self assert: redCount equals: 1.
	self assert: greenCount equals: 1.

	OBlSpace simulateClickOn: redPage titleElement.
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
	
	self newTestingSpace root addChild: aNotebook; show.
	self waitTestingSpaces.
	self assert: (aNotebook pages includes: redPage).

	OBlSpace simulateClickOn: redPage closeButton.
	self waitTestingSpaces.
	self deny: (aNotebook pages includes: redPage).
	self assert: greenPage isSelected.

]

{ #category : #tests }
ToNotebookTest >> testDefaultBodyIsTransparent [

	| aNotebook aPage |
	aNotebook := ToNotebook new.
	aPage := aNotebook addPageTitle: '1'.

	self newTestingSpace root addChild: aNotebook; show.
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
	
	self newTestingSpace root addChild: aNotebook; show.
	self waitTestingSpaces.
	self assert: orangePage isSelected.
	self deny: greenPage isSelected.

	OBlSpace simulateClickOn: greenPage titleElement.
	self waitTestingSpaces.
	self assert: greenPage isSelected.
	self deny: orangePage isSelected.

]

{ #category : #tests }
ToNotebookTest >> waitTestingSpaces [

	testingSpaces do: [ :each |
		self assert: (OBlSpace
			pulseUntilEmptyTaskQueue: each
			timeout: 200 milliSeconds) ]
]
