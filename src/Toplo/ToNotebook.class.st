Class {
	#name : #ToNotebook,
	#superclass : #ToElement,
	#instVars : [
		'pages',
		'header',
		'selectedPage'
	],
	#category : #'Toplo-Widget-Notebook'
}

{ #category : #adding }
ToNotebook >> addPage: aPage [

	pages add: aPage.
	aPage
		whenIsSelectedChangedDo: [ :new :old |
			new = old
				ifTrue: [ 'isSelected didnt change!' traceCr ]
				ifFalse: [ self refreshOnPageIsSelectedChange: aPage ] ];
		whenIsCloseableChangedDo: [ self refreshOnPageIsCloseableChange: aPage ].

	aPage bodyElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	header addChild: aPage titleElement.
	
	pages size = 1 ifTrue: [ aPage isSelected: true ]
]

{ #category : #adding }
ToNotebook >> addPageTitle: aTitle body: aBlElement [ 

	| aPage |
	aPage := ToNotebookPage new.
	aPage
		titleElement: (self newTitleElementFor: aPage title: aTitle);
		bodyElement: aBlElement.

	self addPage: aPage.
	^ aPage
]

{ #category : #'t - initialization dresser' }
ToNotebook >> defaultDresser [

	^ ToNotebookDresser new
]

{ #category : #accessing }
ToNotebook >> header [

	^ header
]

{ #category : #initialization }
ToNotebook >> initialize [

	super initialize.

	pages := OrderedCollection new.
	"selectedPage := nil."

	header := BlElement new.
	self addChild: header as: #header.

	self initializeDresser

]

{ #category : #'instance creation' }
ToNotebook >> newTitleElementFor: aPage title: aTitle [

	^ ToNotebookPageTitle new
		page: aPage;
		title: aTitle;
		whenClickedDo: [ aPage isSelected: true ];
		dresser: self dresser newPageTitleDresser;
		yourself
]

{ #category : #accessing }
ToNotebook >> pages [

	^ pages
]

{ #category : #api }
ToNotebook >> refreshOnPageIsCloseableChange: aPage [

	aPage isCloseable
		ifTrue: [
			| but |
			but := ToButton new.
			but icon: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #windowClose)).
			but whenClickedDo: [ self removePage: aPage ].
			aPage titleElement addChild: but as: #closeButton ]
		ifFalse: [
			aPage titleElement removeChildNamed: #closeButton ]
]

{ #category : #api }
ToNotebook >> refreshOnPageIsSelectedChange: aPage [

	aPage isSelected
		ifTrue: [
			"Single selection only, for now, so deselect current."
			selectedPage ifNotNil: [ 
				selectedPage isSelected: false ].
			self addChild: aPage bodyElement as: #body.
			selectedPage := aPage ]
		ifFalse: [
			self removeChildNamed: #body.
			selectedPage := nil ]
]

{ #category : #removing }
ToNotebook >> removePage: aPage [

	aPage isSelected ifTrue: [
		aPage isSelected: false ].

	header removeChild: aPage titleElement.
	
	self flag: #todo. "Unsubscribe from aPage"

	pages remove: aPage.

	(selectedPage isNil and: [ pages isNotEmpty ])
		ifTrue: [ pages last isSelected: true ]
]

{ #category : #api }
ToNotebook >> selectPage: aPage [

	aPage isSelected: true
]
