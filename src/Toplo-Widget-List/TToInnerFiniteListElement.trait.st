Trait {
	#name : #TToInnerFiniteListElement,
	#instVars : [
		'dataSource',
		'dataSourceManager',
		'listElement',
		'dataSourceObserver'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'t - inner finite list element - accessing nodes' }
TToInnerFiniteListElement >> addAllNodeContainers: anArray at: aPosition [

	| pos |
	pos := aPosition.
	anArray do: [ :container |
			self addNodeContainer: container at: pos.
			self notifyChildAttached: container.
			pos := pos + 1 ]
]

{ #category : #'t - inner finite list element - requirements' }
TToInnerFiniteListElement >> addNodeContainer: aNodeContainer at: aPosition [

	self shouldBeImplemented 
]

{ #category : #'t - inner finite list element - private - commands' }
TToInnerFiniteListElement >> addedDataSourceCommand: aCommand [
]

{ #category : #'t - inner finite list element - configuration' }
TToInnerFiniteListElement >> applyInnerFiniteListElementConfiguration [

	self fitParent: listElement.
	self childrenDo: [ :child | child applyConfiguration ]
]

{ #category : #'t - inner finite list element - private - commands' }
TToInnerFiniteListElement >> consumeFinalStepCommands [

	dataSourceManager consumeFinalStepCommandsIn: self
]

{ #category : #'t - inner finite list element - private - commands' }
TToInnerFiniteListElement >> consumePendingDataSourceCommands [
]

{ #category : #'t - inner finite list element - accessing' }
TToInnerFiniteListElement >> dataSource [

	^ dataSource
]

{ #category : #'t - inner finite list element - accessing' }
TToInnerFiniteListElement >> dataSourceManager [

	^ dataSourceManager 
]

{ #category : #'t - inner finite list element - initialization' }
TToInnerFiniteListElement >> defaultDataSource [ 

	^ listElement dataSource.
]

{ #category : #'t - inner finite list element - initialization' }
TToInnerFiniteListElement >> defaultDataSourceManager [

	^ ToInnerFiniteListDataSourceManager new
		  innerListElement: self;
		  yourself
]

{ #category : #'t - inner finite list element - initialization' }
TToInnerFiniteListElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"

	^ ToInnerFiniteListDataSourceObserver
]

{ #category : #'t - inner finite list element - private - commands' }
TToInnerFiniteListElement >> hasPendingCommands [

	^ dataSourceManager hasPendingCommands
]

{ #category : #'t - inner finite list element - initialization' }
TToInnerFiniteListElement >> initializeAsToInnerFiniteElement [

	self elevation: (BlRelativeElevation elevation: 10).
	self initializeDataSource.
	self addEventHandler: ToScrollableFiniteListElementEventHandler new.
	self matchParent.
	self focusability: BlFocusability ignore.
	listElement primarySelectionMode selectionOption
		grouped: false;
		beneath: true.
	listElement contextMenuSelectionMode selectionOption
		grouped: false;
		beneath: false.
]

{ #category : #'t - inner finite list element - initialization' }
TToInnerFiniteListElement >> initializeDataSource [

	dataSource := self defaultDataSource.
	dataSource onAttached: self.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager.
	self addEventHandlerOn: BlElementRemovedFromParentEvent doOnce: [
			dataSource onDetached: self.
			dataSource removeEventHandler: dataSourceObserver.
			dataSourceManager := nil ]
]

{ #category : #'t - inner finite list element - accessing' }
TToInnerFiniteListElement >> innerElement [

	^ self
]

{ #category : #'t - inner finite list element - accessing' }
TToInnerFiniteListElement >> listElement [

	^ listElement
]

{ #category : #'t - inner finite list element - initialization' }
TToInnerFiniteListElement >> newNodeHolderFromDataSource: aDataSource [

	^ listElement nodeManager newHolder
]

{ #category : #'t - inner finite list element - accessing' }
TToInnerFiniteListElement >> nodeManager [

	^ self listElement nodeManager
]

{ #category : #'t - inner finite list element - data source updates' }
TToInnerFiniteListElement >> offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount [

	"self nodeContainersDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder shouldIgnore not and: [
			 anElementHolder position >= aStartPosition ]) ifTrue: [
			anElementHolder offsetPositionBy: anItemCount ] ].
	self requestLayout"
]

{ #category : #'t - inner finite list element - data source updates' }
TToInnerFiniteListElement >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	self nodeContainersDo: [ :container |
		| pos |
		pos := container holder position.
		(pos >= aPositionStart and: [ pos < (aPositionStart + anItemCount) ])
			ifTrue: [
				container requestConfiguration ] ]
]

{ #category : #'t - inner finite list element - data source updates' }
TToInnerFiniteListElement >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	| holder offsetPosition containers |
	" consume the comands that can contain a selection shift command "
	self consumeFinalStepCommands.
	self
		shiftPositionsFrom: aPositionStart + anItemCount - 1
		by: anItemCount.
	containers := Array streamContents: [ :stream |
			           1 to: anItemCount do: [ :idx |
					           holder := self dataSource createHolder: self.
					           offsetPosition := aPositionStart + idx - 1.
					           holder infiniteElement: self.
					           self dataSource bindHolder: holder at: offsetPosition.
					           stream nextPut: holder nodeContainer] ].
	self addAllNodeContainers: containers at: aPositionStart
]

{ #category : #'t - inner finite list element - data source updates' }
TToInnerFiniteListElement >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	| allContainers |
	allContainers := self nodeContainersSelect: [ :container |
		         container holder position
			         between: aPositionStart 
			         and: aPositionStart + anItemCount - 1].
	self removeAllNodeContainers: allContainers.
	self updatePositions

]

{ #category : #'t - inner finite list element - data source updates' }
TToInnerFiniteListElement >> onItemsChanged [

	| containers |
	self dataSourceManager resetFinalStepCommands.
	self removeAllNodeContainers: self nodeContainers.
	containers := Array streamContents: [ :stream |
			              1 to: self dataSource itemCount do: [ :idx |
					              | holder |
					              holder := self dataSource createHolder: self.
					              holder infiniteElement: self.
					              self dataSource bindHolder: holder at: idx.
					              stream nextPut: holder nodeContainer ] ].
	self addAllNodeContainers: containers at: 1.
	self updatePositions
]

{ #category : #'t - inner finite list element - accessing nodes' }
TToInnerFiniteListElement >> removeAllNodeContainers: anArray [

	anArray reverseDo: [ :container | 
		self removeNodeContainer: container.
		self notifyChildDetached: container  ]
]

{ #category : #'t - inner finite list element - requirements' }
TToInnerFiniteListElement >> removeNodeContainer: aNode [

	self shouldBeImplemented 
]

{ #category : #'t - inner finite list element - data source updates' }
TToInnerFiniteListElement >> shiftPositionsFrom: aStartPosition by: aDelta [

	aStartPosition to: self nodeContainers size do: [ :p |
			| container |
			container := self nodeContainers at: p.
			container holder bindAtPosition: p + aDelta ]
]

{ #category : #'t - inner finite list element - scrolling requirements' }
TToInnerFiniteListElement >> stopScroll [
]

{ #category : #'t - inner finite list element - data source updates' }
TToInnerFiniteListElement >> updatePositions [

	| pos |
	pos := 0.
	self nodeContainersDo: [ :container |
		pos := pos + 1.
		container holder bindAtPosition: pos ]
]

{ #category : #'t - inner finite list element - configuration' }
TToInnerFiniteListElement >> withDecoration: aDecorationClass [
]
