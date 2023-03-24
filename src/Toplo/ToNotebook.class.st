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

	header addChild: aPage titleElement.

	aPage bodyElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	pages size = 1 ifTrue: [ self selectPage: aPage ]
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
		title: aTitle;
		whenClickedDo: [ self selectPage: aPage ];
		dresser: self dresser newPageTitleDresser;
		yourself
]

{ #category : #accessing }
ToNotebook >> pages [

	^ pages
]

{ #category : #api }
ToNotebook >> selectPage: aPage [

	"Remove current selection, if any."
	selectedPage ifNotNil: [ 
		selectedPage titleElement isSelected: false.
		self removeChildNamed: #body ].

	"Add the newly selected page."
	aPage titleElement isSelected: true.

	self addChild: aPage bodyElement as: #body.
	selectedPage := aPage
]
