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

{ #category : #api }
ToNotebook >> addPage: aPage [

	pages add: aPage.
	aPage
		whenIsSelectedChangedDo: [ :new :old |
			new = old
				ifTrue: [ 'isSelected didnt change!' traceCr ]
				ifFalse: [ self refreshOnPageIsSelectedChange: aPage ] ];
		whenIsCloseableChangedDo: [ self refreshOnPageIsCloseableChange: aPage ];
		whenBodyFactoryChangedDo: [ self refreshOnBodyFactoryChange: aPage ].

	header addChild: aPage titleElement.
	
	pages size = 1 ifTrue: [ aPage isSelected: true ]
]

{ #category : #adding }
ToNotebook >> addPageTitle: aTitle [

	| aPage |
	aPage := self newPageTitle: aTitle.
	self addPage: aPage.
	^ aPage
]

{ #category : #api }
ToNotebook >> addPageTitle: aTitle body: aBlElement [ 

	| aPage |
	aPage := self newPageTitle: aTitle.
	aPage bodyElement: aBlElement.
	self addPage: aPage.
	^ aPage
]

{ #category : #adding }
ToNotebook >> addPageTitle: aTitle bodyFactory: aValuable [

	| aPage |
	aPage := self newPageTitle: aTitle.
	aPage bodyFactory: aValuable.
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

{ #category : #private }
ToNotebook >> newPageTitle: aTitle [

	| aPage titleElement |
	aPage := ToNotebookPage new.
	titleElement := self newTitleElementFor: aPage title: aTitle.
	aPage titleElement: titleElement.
	^ aPage
]

{ #category : #private }
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

{ #category : #'t - initialization dresser' }
ToNotebook >> preInitializeDresser [

	super preInitializeDresser.

	pages := OrderedCollection new.
	"selectedPage := nil."

	header := BlElement new.
	self addChild: header as: #header
]

{ #category : #private }
ToNotebook >> refreshOnBodyFactoryChange: aPage [

	selectedPage = aPage ifFalse: [ ^ self ].

	self removeBodyElement.
	self setBodyElement: aPage bodyElement

]

{ #category : #private }
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

{ #category : #private }
ToNotebook >> refreshOnPageIsSelectedChange: aPage [

	aPage isSelected
		ifTrue: [ "Single selection only, for now, so deselect current."
			selectedPage ifNotNil: [ selectedPage isSelected: false ].
			self setBodyElement: aPage bodyElement.
			selectedPage := aPage ]
		ifFalse: [
			self removeBodyElement.
			selectedPage := nil ]
]

{ #category : #private }
ToNotebook >> removeBodyElement [

	self removeChildNamed: #body
]

{ #category : #api }
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

{ #category : #accessing }
ToNotebook >> selectedPage [

	^ selectedPage
]

{ #category : #private }
ToNotebook >> setBodyElement: aBlElement [

	aBlElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self addChild: aBlElement as: #body
]
