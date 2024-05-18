Class {
	#name : #ToScrollableBarElement,
	#superclass : #ToScrollableElement,
	#instVars : [
		'horizontal',
		'dataSource',
		'dataSourceObserver',
		'dataSourceManager',
		'parentBarElement',
		'trackElement',
		'fakeNode',
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-InnerLinearBar'
}

{ #category : #'instance creation' }
ToScrollableBarElement class >> onLinearBarElement: aLinearBarElement [

	^ self basicNew
		  parentBarElement: aLinearBarElement;
		  initialize
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> addHolders: anArray [


	anArray do: [ :h | trackElement addChild: h node ]
]

{ #category : #initialization }
ToScrollableBarElement >> configurateLayout [

	self isHorizontal
		ifTrue: [
			self constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent.
				c linear vertical alignCenter ] ]
		ifFalse: [
			self constraintsDo: [ :c |
				c vertical matchParent.
				c horizontal fitContent.
				c linear horizontal alignCenter ] ].

	self isHorizontal
		ifTrue: [
			trackElement layout: (self isNodeWrapping
					 ifTrue: [ BlFlowLayout horizontal ]
					 ifFalse: [ BlLinearLayout horizontal ]).
			trackElement constraintsDo: [ :c |
				c vertical fitContent.
				self isNodeScrolling
					ifTrue: [ c horizontal fitContent ]
					ifFalse: [ c horizontal matchParent ] ] ]
		ifFalse: [
			trackElement layout: (self isNodeWrapping
					 ifTrue: [ BlFlowLayout vertical ]
					 ifFalse: [ BlLinearLayout vertical ]).
			trackElement constraintsDo: [ :c |
				c horizontal fitContent.
				self isNodeScrolling
					ifTrue: [ c vertical fitContent ]
					ifFalse: [ c vertical matchParent ] ] ].

	self isNodeScrolling ifFalse: [
		self isNodeAutoDistribution ifTrue: [
			self nodesDo: [ :n | n autoDistribute ] ] ].
	
	self installFakeNode
]

{ #category : #accessing }
ToScrollableBarElement >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToScrollableBarElement >> dataSourceManager [

	^ dataSourceManager 
]

{ #category : #initialization }
ToScrollableBarElement >> defaultDataSource [ 

	^ parentBarElement dataSource.
]

{ #category : #initialization }
ToScrollableBarElement >> defaultDataSourceManager [

	^ ToScrollableBarDataSourceManager new
		  scrollableBarElement: self;
		  yourself
]

{ #category : #initialization }
ToScrollableBarElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"

	^ ToScrollableBarDataSourceObserver
]

{ #category : #initialization }
ToScrollableBarElement >> initialize [ 

	super initialize.
	self background: (Color yellow alpha: 0.2).
	self initializeDataSource.
	self id: #scrollable.
	trackElement := ToElement new.
	trackElement id: #track.
	self addChild: trackElement.
	self matchParent
]

{ #category : #initialization }
ToScrollableBarElement >> initializeDataSource [

	dataSource := self defaultDataSource.
	dataSource onAttached: self.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager
]

{ #category : #initialization }
ToScrollableBarElement >> installFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].

	fakeNode := self newNode.
	fakeNode id: #fakeNode.
	fakeNode holder dataItem: fakeDataItem.
	self nodeBuilder value: fakeNode value: fakeNode holder.
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

	" add the fake node (to keep a constant minimum height )"
	trackElement addChild: fakeNode
]

{ #category : #testing }
ToScrollableBarElement >> isHorizontal [

	^ parentBarElement isHorizontal
]

{ #category : #testing }
ToScrollableBarElement >> isNodeAutoDistribution [

	^ parentBarElement nodeAutoDistribution
]

{ #category : #testing }
ToScrollableBarElement >> isNodeScrolling [

	^ parentBarElement nodeScrolling
]

{ #category : #testing }
ToScrollableBarElement >> isNodeWrapping [

	^ parentBarElement nodeWrapping
]

{ #category : #accessing }
ToScrollableBarElement >> listElement [

	^ self parentBarElement 
]

{ #category : #'instance creation' }
ToScrollableBarElement >> newNodeHolderFromDataSource: aDataSource [

	^ parentBarElement nodeManager newNodeHolder
]

{ #category : #'t - infinite accessing' }
ToScrollableBarElement >> nodeContainer [

	^ self
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> nodesDo: aBlock [

	trackElement childrenDo: [ :node | aBlock value: node]
]

{ #category : #accessing }
ToScrollableBarElement >> parentBarElement [

	^ parentBarElement
]

{ #category : #accessing }
ToScrollableBarElement >> parentBarElement: anObject [

	parentBarElement := anObject
]

{ #category : #'accessing - children' }
ToScrollableBarElement >> selectableNodeContainingGlobalPosition: aPoint [

	self nodesDo: [ :node |
		(node holder isSelectable and: [ node containsGlobalPoint: aPoint ])
			ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #'t - infinite accessing' }
ToScrollableBarElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"

	
]
