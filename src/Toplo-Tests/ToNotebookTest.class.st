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
	
	self newTestingSpace addChild: aNotebook; show.
	self waitTestingSpaces.
	self assert: orangePage titleElement isSelected.
	self deny: greenPage titleElement isSelected.

	OBlSpace simulateClickOn: greenPage titleElement.
	self waitTestingSpaces.
	self assert: greenPage titleElement isSelected.
	self deny: orangePage titleElement isSelected.

]

{ #category : #tests }
ToNotebookTest >> waitTestingSpaces [

	testingSpaces do: [ :each |
		self assert: (OBlSpace
			pulseUntilEmptyTaskQueue: each
			timeout: 200 milliSeconds) ]
]
