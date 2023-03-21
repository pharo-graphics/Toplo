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

	^ (ParametrizedTestMatrix new forSelector: #hostClass addOptions: {
		   BlMockedHost.
			BlOSWindowSDL2Host.
		   BlMorphicWindowHost })
]

{ #category : #tests }
ToNotebookTest >> assertNoPendingTasks [

	testingSpaces do: [ :each |
		self assert: (OBlSpace
			pulseUntilEmptyTaskQueue: each
			timeout: 200 milliSeconds) ]
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
	hostClass traceCr.
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

	self assertNoPendingTasks.
	testingSpaces do: [ :each |
		each host traceCr. "1halt."
		each close ].
	self assertNoPendingTasks.
	
	super tearDown.

]

{ #category : #tests }
ToNotebookTest >> testAddTwoPages [

	| aNotebook aSpace orangePage greenPage |
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
	
	aSpace := self newTestingSpace.
	aSpace root background: Color veryDarkGray.
	aSpace show.
	aSpace addChild: aNotebook.
	self assertNoPendingTasks.

	
	self assert: orangePage titleElement isSelected.
	self deny: greenPage titleElement isSelected.

	OBlSpace simulateClickOn: greenPage titleElement.
	self assertNoPendingTasks.
	self assert: greenPage titleElement isSelected.
	self deny: orangePage titleElement isSelected.

]
