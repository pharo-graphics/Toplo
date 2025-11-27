Class {
	#name : #ToInfiniteElement,
	#superclass : #BlInfiniteElement,
	#traits : 'TToListInnerElement',
	#classTraits : 'TToListInnerElement classTrait',
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #'instance creation' }
ToInfiniteElement class >> onListElement: aListElement [

	^ self basicNew
		  onListElement: aListElement;
		  initialize
]

{ #category : #'private - commands' }
ToInfiniteElement >> addedDataSourceCommand: aCommand [

	self requestLayout
]

{ #category : #configuration }
ToInfiniteElement >> applyConfiguration [

	super applyConfiguration.
	self layout beHorizontal: self listElement isHorizontal.
	self constraintsDo: [ :c |
			self listElement isHMatchParent
				ifTrue: [ c horizontal matchParent ]
				ifFalse: [ c horizontal fitContent ].
			self listElement isVMatchParent
				ifTrue: [ c vertical matchParent ]
				ifFalse: [ c vertical fitContent ] ]
]

{ #category : #'private - commands' }
ToInfiniteElement >> applyDataSourceFilterCommand: aDataSourceCommand [

	listElement applyDataSourceFilterCommand: aDataSourceCommand
]

{ #category : #'private - commands' }
ToInfiniteElement >> applyDataSourceSieveCommand: aDataSourceCommand [

	listElement applyDataSourceSieveCommand: aDataSourceCommand
]

{ #category : #'t - infinite accessing' }
ToInfiniteElement >> cleanUpRecyclerAt: anIndex [

	self customRecycler removeNodeAt: anIndex in: self
]

{ #category : #layout }
ToInfiniteElement >> consumeFinalStepCommands [

	dataSourceManager consumeFinalStepCommandsIn: self
]

{ #category : #'t - infinite accessing' }
ToInfiniteElement >> customRecycler [

	^ self recycler customRecycler
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
ToInfiniteElement >> defaultRecycler [

	^ ToInfiniteRecycler new
]

{ #category : #initialization }
ToInfiniteElement >> defaultScrollFlinger [
	"Return class, actuall instantiation happens in initialize"
	^ ToInfiniteScrollFlinger
]

{ #category : #layout }
ToInfiniteElement >> dispatchLayoutFinalStep [

	super dispatchLayoutFinalStep.
	self assert: dataSourceManager hasCommands not.
	self consumeFinalStepCommands.
	"If an element bounds change then the selection bounds may be obsolete"
	self boundsUpdaterHasChanges ifTrue: [ listElement updateAllSelections ].

]

{ #category : #'t - list node holder' }
ToInfiniteElement >> findElementHolderForDataSourcePosition: aPosition [

	^ super findElementHolderForDataSourcePosition: aPosition
]

{ #category : #initialization }
ToInfiniteElement >> initialize [

	super initialize.
	self addEventHandler: ToListInnerElementEventHandler new
]

{ #category : #'t - infinite accessing' }
ToInfiniteElement >> innerElement [ 

	^ self
]

{ #category : #accessing }
ToInfiniteElement >> listElement [

	^ listElement
]

{ #category : #'instance creation' }
ToInfiniteElement >> newNodeHolderFromDataSource: aDataSource [

	^ listElement nodeManager newHolder
]

{ #category : #'t - list node holder' }
ToInfiniteElement >> nodeContainerAt: aPosition [

	^ (self findElementHolderForDataSourcePosition: aPosition) ifNotNil: [
		  :holder | holder node ]
]

{ #category : #'t - list node holder' }
ToInfiniteElement >> nodeContainers [

	^ self children
]

{ #category : #'t - list node holder' }
ToInfiniteElement >> nodeContainersDetect: aBlock [

	self nodeContainersDo: [ :container | (aBlock value: container) ifTrue: [ ^ container ] ].
	^ nil
]

{ #category : #'t - list node holder' }
ToInfiniteElement >> nodeContainersDo: aBlock [

	self childrenDo: [ :node | aBlock value: node ]
]

{ #category : #'t - list node holder' }
ToInfiniteElement >> nodeContainersReject: aBlock [

	^ self nodeContainersSelect: [ :container | (aBlock value: container) not ]
]

{ #category : #'t - list node holder' }
ToInfiniteElement >> nodeContainersSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodeContainersDo: [ :container |
			  (aBlock value: container) ifTrue: [ stream nextPut: container ] ] ]
]

{ #category : #'t - list node holder' }
ToInfiniteElement >> nodeContainersWithIndexDo: aBlock [

	self nodeContainersDo: [ :container |
		aBlock value: container value: container holder position ]
]

{ #category : #'accessing - children' }
ToInfiniteElement >> nodeContainingGlobalPosition: aPoint [

	self nodeContainersDo: [ :container |
		(container containsGlobalPoint: aPoint) ifTrue: [ ^ container ] ].
	^ nil
]

{ #category : #initialization }
ToInfiniteElement >> onListElement: aListElement [

	listElement := aListElement
]

{ #category : #'t - list node holder' }
ToInfiniteElement >> partlyVisibleNodesDo: aBlock [

	self nodeContainersDo: aBlock
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
