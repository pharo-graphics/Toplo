Class {
	#name : #ToLinearBarInnerElement,
	#superclass : #ToTripletElement,
	#instVars : [
		'listElement',
		'dataSource',
		'dataSourceObserver',
		'dataSourceManager',
		'scrollable',
		'fakeDataItem',
		'fakeNode'
	],
	#category : #'Toplo-Widget-List-InnerLinearBar'
}

{ #category : #'instance creation' }
ToLinearBarInnerElement class >> onLinearBarElement: aLinearBarElement [

	^ self basicNew
		  listElement: aLinearBarElement;
		  initialize
]

{ #category : #adding }
ToLinearBarInnerElement >> addAllHolders: anArray at: aPosition [

	scrollable addAllHolders: anArray at: aPosition
]

{ #category : #initialization }
ToLinearBarInnerElement >> configureLayoutIn: aListElement [

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
ToLinearBarInnerElement >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToLinearBarInnerElement >> dataSourceManager [

	^ dataSourceManager 
]

{ #category : #initialization }
ToLinearBarInnerElement >> defaultDataSource [ 

	^ listElement dataSource.
]

{ #category : #initialization }
ToLinearBarInnerElement >> defaultDataSourceManager [

	^ ToScrollableBarDataSourceManager new
		  innerLinearBarElement: self;
		  yourself
]

{ #category : #initialization }
ToLinearBarInnerElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"

	^ ToScrollableBarDataSourceObserver
]

{ #category : #accessing }
ToLinearBarInnerElement >> fakeDataItem: anObject [

	fakeDataItem := anObject. 
	self installFakeNode.
]

{ #category : #initialization }
ToLinearBarInnerElement >> initialize [ 

	super initialize.
	self initializeDataSource.
	self id: #innerElement.
	scrollable := ToScrollableBarElement new.
	scrollable id: #scrollable.
	self middleElement: scrollable.
	self matchParent
]

{ #category : #initialization }
ToLinearBarInnerElement >> initializeDataSource [

	dataSource := self defaultDataSource.
	dataSource onAttached: self.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager
]

{ #category : #initialization }
ToLinearBarInnerElement >> installFakeNode [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| holder |
	fakeNode ifNotNil: [ :fn | fn removeFromParent ].
	holder := self dataSource createHolder: self.
	holder infiniteElement: self.
	holder dataItem: fakeDataItem.
	fakeNode := self listElement nodeManager newNodeInHolder: holder.
	self listElement nodeManager builderNode: fakeNode inHolder: holder.
	holder node: fakeNode.
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
	scrollable addHolder: holder at: dataSource itemCount + 1 
]

{ #category : #accessing }
ToLinearBarInnerElement >> listElement [

	^ listElement
]

{ #category : #accessing }
ToLinearBarInnerElement >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #'instance creation' }
ToLinearBarInnerElement >> newNodeHolderFromDataSource: aDataSource [

	^ self listElement nodeManager newNodeHolder
]

{ #category : #'t - infinite accessing' }
ToLinearBarInnerElement >> nodeContainer [

	^ self
]

{ #category : #'accessing - nodes' }
ToLinearBarInnerElement >> nodeGroupsSatisfying: aBlock [
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
ToLinearBarInnerElement >> nodesDo: aBlock [

	scrollable nodesDo: aBlock
]

{ #category : #'data source updates' }
ToLinearBarInnerElement >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

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

{ #category : #'accessing - children' }
ToLinearBarInnerElement >> selectableNodeContainingGlobalPosition: aPoint [

	self nodesDo: [ :node |
		(node holder isSelectable and: [ node containsGlobalPoint: aPoint ])
			ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #'t - infinite accessing' }
ToLinearBarInnerElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"

	
]
