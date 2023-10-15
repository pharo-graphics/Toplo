Class {
	#name : 'ToNotebook',
	#superclass : 'ToElement',
	#instVars : [
		'pages',
		'header',
		'selectedPage'
	],
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'api' }
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

{ #category : 'adding' }
ToNotebook >> addPageTitle: aTitle [

	| aPage |
	aPage := self newPageTitle: aTitle.
	self addPage: aPage.
	^ aPage
]

{ #category : 'api' }
ToNotebook >> addPageTitle: aTitle body: aBlElement [ 

	| aPage |
	aPage := self newPageTitle: aTitle.
	aPage bodyElement: aBlElement.
	self addPage: aPage.
	^ aPage
]

{ #category : 'adding' }
ToNotebook >> addPageTitle: aTitle bodyFactory: aValuable [

	| aPage |
	aPage := self newPageTitle: aTitle.
	aPage bodyFactory: aValuable.
	self addPage: aPage.
	^ aPage
]

{ #category : 'accessing' }
ToNotebook >> header [

	^ header
]

{ #category : 'initialization' }
ToNotebook >> initialize [

	super initialize.

	header := BlElement new.
	self addChild: header as: #header.
	pages := OrderedCollection new.
	self
		background: self theme notebook backgroundColor;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	self header
		layout: (BlLinearLayout horizontal
				 cellSpacing: 4;
				 yourself);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 30 ]
]

{ #category : 'private' }
ToNotebook >> newPageTitle: aTitle [

	| aPage titleElement |
	aPage := ToNotebookPage new.
	titleElement := self newTitleElementFor: aPage title: aTitle.
	aPage titleElement: titleElement.
	^ aPage
]

{ #category : 'private' }
ToNotebook >> newTitleElementFor: aPage title: aTitle [

	^ ToNotebookPageTitle new
		page: aPage;
		title: aTitle;
		whenClickedDo: [ aPage isSelected: true ];
		yourself
]

{ #category : 'accessing' }
ToNotebook >> pages [

	^ pages
]

{ #category : 'private' }
ToNotebook >> refreshOnBodyFactoryChange: aPage [

	selectedPage = aPage ifFalse: [ ^ self ].

	self removeBodyElement.
	self setBodyElement: aPage bodyElement

]

{ #category : 'private' }
ToNotebook >> refreshOnPageIsCloseableChange: aPage [

	aPage isCloseable
		ifTrue: [
			| but |
			but := ToButton new defaultSkin: nil.
			but icon: (ToImage new innerImage: (Smalltalk ui icons iconNamed: #windowClose)).
			but constraintsDo: [ :c | c linear vertical alignCenter].
			but whenClickedDo: [ :evt | 
				evt consumed: true.
				self removePage: aPage ].
			aPage titleElement addChild: but as: #closeButton ]
		ifFalse: [
			aPage titleElement removeChildNamed: #closeButton ]
]

{ #category : 'private' }
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

{ #category : 'private' }
ToNotebook >> removeBodyElement [

	self removeChildWithId: #body
]

{ #category : 'api' }
ToNotebook >> removePage: aPage [

	| pageIndex |
	aPage isSelected ifTrue: [ 
		pageIndex := pages indexOf: aPage ].
	header removeChild: aPage titleElement.
	aPage isSelected: false.
	pages remove: aPage.
	self flag: #todo. "Unsubscribe from aPage"
	
	pageIndex ifNil: [ ^self ].
	pages ifEmpty: [ ^self ].

	((pages size < pageIndex)
		ifTrue: [ pages last ]
		ifFalse: [ pages at: pageIndex ]) isSelected: true
]

{ #category : 'api' }
ToNotebook >> selectPage: aPage [

	aPage isSelected: true
]

{ #category : 'accessing' }
ToNotebook >> selectedPage [

	^ selectedPage
]

{ #category : 'private' }
ToNotebook >> setBodyElement: aBlElement [

	aBlElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self addChild: aBlElement as: #body
]
