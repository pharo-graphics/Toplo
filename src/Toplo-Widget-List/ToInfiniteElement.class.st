Class {
	#name : #ToInfiniteElement,
	#superclass : #BlInfiniteElement,
	#traits : 'TBlLayoutResizable',
	#classTraits : 'TBlLayoutResizable classTrait',
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #'instance creation' }
ToInfiniteElement class >> onListElement: aListElement [

	^ self basicNew
		  listElement: aListElement;
		  initialize
]

{ #category : #'private - commands' }
ToInfiniteElement >> applyDataSourceFilterCommand: aDataSourceCommand [

	listElement applyDataSourceFilterCommand: aDataSourceCommand
]

{ #category : #'private - commands' }
ToInfiniteElement >> applyDataSourceSieveCommand: aDataSourceCommand [

	listElement applyDataSourceSieveCommand: aDataSourceCommand
]

{ #category : #initialization }
ToInfiniteElement >> defaultDataSource [

	^ self listElement dataSource
]

{ #category : #initialization }
ToInfiniteElement >> defaultDataSourceManager [

	^ ToInfiniteDataSourceManager new
]

{ #category : #initialization }
ToInfiniteElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"
	^ ToInfiniteDataSourceObserver
]

{ #category : #initialization }
ToInfiniteElement >> defaultLayout [

	^ BlInfiniteLinearLayout new
]

{ #category : #initialization }
ToInfiniteElement >> defaultMouseScrollEventHandler [

	^ BlInfiniteMouseScrollListener new
		  restrictedByOrientation: true;
		  yourself
]

{ #category : #initialization }
ToInfiniteElement >> defaultScrollFlinger [
	"Return class, actuall instantiation happens in initialize"
	^ ToInfiniteScrollFlinger
]

{ #category : #'scrolled event' }
ToInfiniteElement >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #'scrolled event' }
ToInfiniteElement >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent 
]

{ #category : #'node enumerating' }
ToInfiniteElement >> fullyVisibleNodesDo: aBlock [

	self nodesDo: aBlock
]

{ #category : #'node enumerating' }
ToInfiniteElement >> fullyVisibleNodesSelect: aBlock [

	^ self nodesSelect: aBlock
]

{ #category : #initialization }
ToInfiniteElement >> initialize [

	super initialize.
	self addEventHandler: ToListInnerContainerEventHandler new.
	self matchParent
]

{ #category : #'t - infinite accessing' }
ToInfiniteElement >> innerContainer [ 

	^ self
]

{ #category : #'private - invalidation' }
ToInfiniteElement >> invalidateItemDecorations [

	super invalidateItemDecorations.
	listElement invalidateItemDecorations
]

{ #category : #accessing }
ToInfiniteElement >> listElement [

	^ listElement
]

{ #category : #private }
ToInfiniteElement >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #'instance creation' }
ToInfiniteElement >> newNodeHolderFromDataSource: aDataSource [

	^ listElement nodeManager newNodeHolder
]

{ #category : #'accessing - nodes' }
ToInfiniteElement >> nodeAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. 
	Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #'accessing - children' }
ToInfiniteElement >> nodeContainingGlobalPosition: aPoint [

	self nodesDo: [ :node |
		(node containsGlobalPoint: aPoint) ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #'accessing - nodes' }
ToInfiniteElement >> nodeGroupsSatisfying: aBlock [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  self partlyVisibleNodesDo: [ :node |
			  (aBlock value: node)
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #'node enumerating' }
ToInfiniteElement >> nodesDo: aBlock [

	self childrenDo: [ :node | aBlock value: node ]
]

{ #category : #'node enumerating' }
ToInfiniteElement >> nodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #'node enumerating' }
ToInfiniteElement >> nodesWithIndexDo: aBlock [

	self nodesDo: [ :node |
		aBlock value: node value: node holder position ]
]

{ #category : #'hooks - scrolling' }
ToInfiniteElement >> onScrolled: aPoint [

	listElement onScrolled: aPoint
]

{ #category : #'node enumerating' }
ToInfiniteElement >> partlyVisibleNodesDo: aBlock [

	self nodesDo: aBlock
]

{ #category : #'node enumerating' }
ToInfiniteElement >> partlyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self partlyVisibleNodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #private }
ToInfiniteElement >> scrollToDataSourcePosition: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"
	"As a result, if the item at anIndex is not already visible, 
	it is positionned at the top or at the bottom of the listElement "

	self scrollToPosition: anIndex 
]

{ #category : #private }
ToInfiniteElement >> scrollToIndex: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"

	self
		deprecated: 'Use scrollToDataSourcePosition: instead'
		transformWith: '`@receiver scrollToIndex: `@argument'
			-> '`@receiver scrollToDataSourcePosition: `@argument'.

	self scrollToDataSourcePosition: anIndex
]

{ #category : #private }
ToInfiniteElement >> scrollToIndexAtTop: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"
	"As a result, item at anIndex is positionned at the top of the listElement"
	self
		deprecated: 'Use scrollToDataSourcePosition: instead'
		transformWith: '`@receiver scrollToIndexAtTop: `@argument'
			-> '`@receiver scrollToDataSourcePosition: `@argument'.

	self scrollToDataSourcePosition: anIndex
]

{ #category : #private }
ToInfiniteElement >> scrollTowardEndToDataSourcePosition: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"
	"As a result, if the item at anIndex is not already visible, 
	it is positionned at the top or at the bottom of the listElement "

	self scrollToPosition: anIndex 
]

{ #category : #private }
ToInfiniteElement >> scrollTowardStartToDataSourcePosition: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"
	"As a result, if the item at anIndex is not already visible, 
	it is positionned at the top or at the bottom of the listElement "

	self scrollToPosition: anIndex 
]

{ #category : #'accessing - children' }
ToInfiniteElement >> selectableNodeContainingGlobalPosition: aPoint [

	self nodesDo: [ :node |
		(node holder isSelectable and: [ node containsGlobalPoint: aPoint ])
			ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #private }
ToInfiniteElement >> smoothScrollToDataSourcePosition: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"

	self smoothScrollToPosition: anIndex
]

{ #category : #'view - configuration' }
ToInfiniteElement >> withRowNumbers [

	self withDecoration: ToInfiniteRowNumberDecoration
]

{ #category : #'view - configuration' }
ToInfiniteElement >> withoutRowNumbers [

	self withoutDecoration: ToInfiniteRowNumberDecoration
]
