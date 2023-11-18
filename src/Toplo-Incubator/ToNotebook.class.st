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
		when: BlClickEvent
		do: [ :event | self selectedPage: aPage ].
	pages buttons size = 1 ifTrue: [ self selectPage: aPage ]
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
	pages := ToCheckableGroup new
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

	| selectedPageIndex |

	selectedPageIndex := aPage isSelected
		                     ifTrue: [ self indexOfPage: aPage ]
		                     ifFalse: [ 0 ].
	"aPage selected: false."
	pages remove: aPage.
	
	pages buttons ifEmpty: [ ^ self ].
	selectedPageIndex isZero ifTrue: [ ^ self ].
	self selectPage: (pages buttons size < selectedPageIndex
		 ifTrue: [ pages buttons last ]
		 ifFalse: [ pages buttons at: selectedPageIndex ]) 
]

{ #category : 'private' }
ToNotebook >> selectPage: aPage [

	aPage selected: true.
	self selectedPage: aPage
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
