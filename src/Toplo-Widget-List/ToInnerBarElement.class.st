Class {
	#name : #ToInnerBarElement,
	#superclass : #ToTripletElement,
	#instVars : [
		'listElement',
		'dataSource',
		'dataSourceObserver',
		'dataSourceManager',
		'scrollable'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'instance creation' }
ToInnerBarElement class >> onLinearBarElement: aLinearBarElement [

	^ self basicNew
		  listElement: aLinearBarElement;
		  initialize
]

{ #category : #adding }
ToInnerBarElement >> addAllHolders: anArray at: aPosition [

	scrollable addAllHolders: anArray at: aPosition
]

{ #category : #private }
ToInnerBarElement >> checkVisibleNodes [

	| invisibleNodes  |
	scrollable isNodeWrapping ifTrue: [ ^ self ].
	scrollable isNodeScrolling ifTrue: [ ^ self ].
	scrollable isNodeAutoDistribution ifTrue: [ ^ self ].
	invisibleNodes := self nodesSelect: [ :n | n isFullyVisible not ].
	listElement dispatchEvent: (ToBarNodeVisibilityEvent new
			 invisibleNodes: invisibleNodes;
			 yourself)
]

{ #category : #initialization }
ToInnerBarElement >> configureLayoutIn: aListElement [

	self isHorizontal
		ifTrue: [
			self hMatchParent.
			self vFitContent.
			self middleContainer constraintsDo: [ :c |
				c linear vertical alignCenter.
				c horizontal matchParent.
				c vertical fitContent ] ]
		ifFalse: [
			self vMatchParent.
			self hFitContent.
			self middleContainer constraintsDo: [ :c |
				c linear horizontal alignCenter.
				c vertical matchParent.
				c horizontal fitContent ] ].

	scrollable configureLayoutIn: aListElement.
	self installFakeNode
]

{ #category : #accessing }
ToInnerBarElement >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToInnerBarElement >> dataSourceManager [

	^ dataSourceManager 
]

{ #category : #initialization }
ToInnerBarElement >> defaultDataSource [ 

	^ listElement dataSource.
]

{ #category : #initialization }
ToInnerBarElement >> defaultDataSourceManager [

	^ ToScrollableBarDataSourceManager new
		  innerLinearBarElement: self;
		  yourself
]

{ #category : #initialization }
ToInnerBarElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"

	^ ToScrollableBarDataSourceObserver
]

{ #category : #initialization }
ToInnerBarElement >> initialize [ 

	super initialize.
	self initializeDataSource.
	self id: #innerElement.
	scrollable := ToScrollableBarElement new.
	scrollable id: #scrollable.
	self middleElement: scrollable.
	self matchParent
]

{ #category : #initialization }
ToInnerBarElement >> initializeDataSource [

	dataSource := self defaultDataSource.
	dataSource onAttached: self.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager
]

{ #category : #initialization }
ToInnerBarElement >> installFakeNode [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| holder fakeNode |
	holder := dataSource createHolder: self.
	holder infiniteElement: self.
	holder bindAtPosition: 0.
	fakeNode := self listElement nodeManager newFakeNodeInHolder: holder.
	fakeNode id: #fakeNode.
	fakeNode background: Color red.
	self isHorizontal
		ifTrue: [
			fakeNode width: 0.
			fakeNode constraintsDo: [ :c |
				c vertical matchParent.
				c flow vertical alignCenter.
				c linear vertical alignCenter ] ]
		ifFalse: [
			fakeNode height: 0.
			fakeNode constraintsDo: [ :c |
				c horizontal matchParent.
				c flow horizontal alignCenter.
				c linear horizontal alignCenter ] ].

	fakeNode margin: BlInsets empty.

	" add the fake node (to keep a constant minimum size ) "
	scrollable addFakeNode: fakeNode
]

{ #category : #accessing }
ToInnerBarElement >> listElement [

	^ listElement
]

{ #category : #accessing }
ToInnerBarElement >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #'instance creation' }
ToInnerBarElement >> newNodeHolderFromDataSource: aDataSource [

	^ self listElement nodeManager newNodeHolder
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> nodeContainer [

	^ self
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> nodeGroupsSatisfying: aBlock [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  self nodesDo: [ :node |
			  (aBlock value: node)
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #enumerating }
ToInnerBarElement >> nodesDo: aBlock [

	scrollable nodesDo: aBlock
]

{ #category : #enumerating }
ToInnerBarElement >> nodesSelect: aBlock [

	^ scrollable nodesSelect: aBlock
]

{ #category : #'data source notification' }
ToInnerBarElement >> notifyChanged [

	dataSource notifyChanged
]

{ #category : #'data source updates' }
ToInnerBarElement >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	| holder offsetPosition holders |
	holders := Array streamContents: [ :stream |
		           1 to: anItemCount do: [ :idx |
			           holder := self dataSource createHolder: self.
			           offsetPosition := aPositionStart + idx - 1.
			           holder infiniteElement: self.
			           self dataSource bindHolder: holder at: offsetPosition.
			           stream nextPut: holder ] ].
	self addAllHolders: holders at: aPositionStart
]

{ #category : #layout }
ToInnerBarElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self checkVisibleNodes
]

{ #category : #'accessing - children' }
ToInnerBarElement >> selectableNodeContainingGlobalPosition: aPoint [

	self nodesDo: [ :node |
		(node holder isSelectable and: [ node containsGlobalPoint: aPoint ])
			ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"

	
]
