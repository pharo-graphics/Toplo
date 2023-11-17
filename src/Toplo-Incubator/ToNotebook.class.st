Class {
	#name : 'ToNotebook',
	#superclass : 'ToPane',
	#instVars : [
		'pages',
		'header',
		'selectedPage'
	],
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'private' }
ToNotebook >> addPage: aPage [

	pages add: aPage.
	header addChild: aPage button.
	aPage button
		when: ToCheckableChangedEvent
		do: [ :event | self selectedPage: aPage ].
	pages buttons size = 1 ifTrue: [ aPage selected: true ]
]

{ #category : 'adding-removing' }
ToNotebook >> addPageEntitled: aTitle [

	| aPage |
	aPage := self newPageEntitled: aTitle.
	self addPage: aPage.
	^ aPage
]

{ #category : 'adding-removing' }
ToNotebook >> addPageEntitled: aTitle withBody: aBlElement [ 

	| aPage |
	aPage := self newPageEntitled: aTitle.
	aPage bodyElement: aBlElement.
	self addPage: aPage.
	^ aPage
]

{ #category : 'adding-removing' }
ToNotebook >> addPageEntitled: aTitle withBodyBuilder: aValuable [

	| aPage |
	aPage := self newPageEntitled: aTitle.
	aPage bodyBuilder: aValuable.
	self addPage: aPage.
	^ aPage
]

{ #category : 'accessing' }
ToNotebook >> header [

	^ header
]

{ #category : 'accessing' }
ToNotebook >> indexOfPage: aPage [

	^ pages buttons indexOf: aPage
]

{ #category : 'initialization' }
ToNotebook >> initialize [

	super initialize.
	self beVertical.
	self matchParent.
	header := ToPane horizontal.
	self addChild: header as: #header.
	pages := ToCheckableGroup new.
]

{ #category : 'private' }
ToNotebook >> newButtonForPage: aPage entitled: aText [

	^ ToNotebookPageButton new
		page: aPage;
		labelText: aText;
		yourself
]

{ #category : 'private' }
ToNotebook >> newPageEntitled: aText [

	| aPage pageButton |
	aPage := ToNotebookPage new.
	pageButton := self newButtonForPage: aPage entitled: aText.
	pageButton when: BlElementRemovedFromParentEvent do: [ :evt |
		self removePage: aPage ].
	aPage button: pageButton.
	^ aPage
]

{ #category : 'accessing' }
ToNotebook >> pages [

	^ pages
]

{ #category : 'private' }
ToNotebook >> removeBodyElement [

	self removeChildWithId: #body
]

{ #category : 'adding-removing' }
ToNotebook >> removePage: aPage [

	| removedPageSelectedIndex selectedPageIndexes |
	self flag: 'to be fixed'.
	removedPageSelectedIndex := aPage isSelected
		                            ifTrue: [ self indexOfPage: aPage ]
		                            ifFalse: [ 0 ].

	pages remove: aPage.
	pages buttons ifEmpty: [ ^ self ].

	selectedPageIndexes := Array streamContents: [ :str |
		                       pages buttons withIndexDo: [ :p :idx |
			                       p isSelected ifTrue: [ str nextPut: idx ] ] ].

	selectedPageIndexes do: [ :idx | "(pages buttons size < removedPageSelectedIndex
		 ifTrue: [ pages buttons last ]
		 ifFalse: [ pages buttons at: removedPageSelectedIndex ]) selected: true"
		(pages buttons at: idx) selected: true.
		self selectedPage: (pages buttons at: idx) ]
]

{ #category : 'private' }
ToNotebook >> selectPage: aPage [

	aPage selected: true
]

{ #category : 'accessing' }
ToNotebook >> selectedPage [

	^ selectedPage
]

{ #category : 'private' }
ToNotebook >> selectedPage: aPage [

	self removeBodyElement.
	self setBodyElement: aPage bodyElement.
	selectedPage := aPage
]

{ #category : 'private' }
ToNotebook >> setBodyElement: aBlElement [

	aBlElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self addChild: aBlElement as: #body
]
