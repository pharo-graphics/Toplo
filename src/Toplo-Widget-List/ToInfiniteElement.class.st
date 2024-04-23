Class {
	#name : #ToInfiniteElement,
	#superclass : #BlInfiniteElement,
	#traits : 'TBlLayoutResizable',
	#classTraits : 'TBlLayoutResizable classTrait',
	#instVars : [
		'nodeHolderFactory',
		'listElement'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'instance creation' }
ToInfiniteElement class >> onListElement: aListElement [

	^ self basicNew
		  listElement: aListElement;
		  nodeHolderFactory: aListElement defaultNodeHolderFactory;
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

{ #category : #'t - infinite accessing' }
ToInfiniteElement >> infinite [ 

	^ self
]

{ #category : #initialization }
ToInfiniteElement >> initialize [

	super initialize.
	self matchParent
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

	^ self nodeHolderFactory cull: aDataSource
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

	self childrenDo: [ :node |
		(node containsGlobalPoint: aPoint) ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #'accessing - nodes' }
ToInfiniteElement >> nodeGroupsSatisfying: aBlock [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  self childrenDo: [ :node |
			  (aBlock value: node)
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #'accessing - nodes' }
ToInfiniteElement >> nodeHolderFactory [

	"aValuable that takes the data source as argument and returns a node holder instance "
	^ nodeHolderFactory
]

{ #category : #'accessing - nodes' }
ToInfiniteElement >> nodeHolderFactory: aValuable [

	"aValuable that takes the data source as argument and returns a node holder instance "
	nodeHolderFactory := aValuable
]

{ #category : #'t - resizeable' }
ToInfiniteElement >> resizableConstraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	
	Can be basically defined with #constraintsDo: aBlock.
	
	Introduced a an explicit requirement to let user
	implement additional actions when resizing is changed
	
	"
	| hr vr |
	hr := self constraints horizontal resizer.
	vr := self constraints vertical resizer.
	aBlock value: self constraints.
	(hr = self constraints horizontal resizer and: [
		 vr = self constraints vertical resizer ]) ifTrue: [ ^ self ].
	self dispatchEvent: ToLayoutConstraintsChangedEvent new.
	self requestLayout
]

{ #category : #private }
ToInfiniteElement >> scrollToDataSourcePosition: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"

	self scrollToPosition: anIndex.

	"aWish smooth
		ifTrue: [ self listElement smoothScrollToPosition: aWish index ]
		ifFalse: [ self listElement scrollToPosition: aWish index ]"
]

{ #category : #private }
ToInfiniteElement >> scrollToIndex: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"

	self scrollToPosition: anIndex.

	"aWish smooth
		ifTrue: [ self listElement smoothScrollToPosition: aWish index ]
		ifFalse: [ self listElement scrollToPosition: aWish index ]"
]

{ #category : #private }
ToInfiniteElement >> scrollToIndexAtTop: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"
	"As a result, item at anIndex is positionned at the top of the listElement"

	self scrollToPosition: anIndex offset: self layout computeExtraLayoutSpace y.
]

{ #category : #'view - configuration' }
ToInfiniteElement >> withRowNumbers [

	self withDecoration: ToInfiniteRowNumberDecoration
]

{ #category : #'view - configuration' }
ToInfiniteElement >> withoutRowNumbers [

	self withoutDecoration: ToInfiniteRowNumberDecoration
]
