Class {
	#name : #ToBarElement,
	#superclass : #ToAbstractListElement,
	#instVars : [
		'nodeWrapping',
		'nodeScrolling',
		'nodeAutoDistribution',
		'flowLineUniformWidth'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #visiting }
ToBarElement >> accept: aVisitor [

	aVisitor visitBarElement: self
]

{ #category : #layout }
ToBarElement >> checkFullyVisibleNodes [ 

	self innerContainer checkFullyVisibleNodes 
]

{ #category : #layout }
ToBarElement >> configureLayout [

	self accept: self layoutConfigurator.
	self requestLayout
]

{ #category : #initialization }
ToBarElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToBarElement >> defaultInnerContainer [

	^ ToInnerBarElement onBarElement: self
]

{ #category : #initialization }
ToBarElement >> defaultNodeManagerClass [

	^ ToBarNodeManager 
]

{ #category : #accessing }
ToBarElement >> fakeDataItem: aDataItem [

	nodeManager fakeDataItem: aDataItem.
	self configureLayout
	
]

{ #category : #accessing }
ToBarElement >> fakeNode [

	^ self innerContainer fakeNode
]

{ #category : #accessing }
ToBarElement >> flowLineUniformWidth [

	^ flowLineUniformWidth ifNil: [ flowLineUniformWidth := false ]
]

{ #category : #accessing }
ToBarElement >> flowLineUniformWidth: aBoolean [

	flowLineUniformWidth := aBoolean.
	self configureLayout.
	self notifyDataSourceChanged

]

{ #category : #'t - orientable - orientation' }
ToBarElement >> horizontal: aBoolean [

	super horizontal: aBoolean.
	self configureLayout
]

{ #category : #initialization }
ToBarElement >> initialize [

	super initialize.
	selectionMode beSeparateBeneathSelection.
	selectionMode beNoneOverSelection.
	contextMenuSelectionMode beSeparateOverSelection.
	self configureLayout
]

{ #category : #initialization }
ToBarElement >> initializeInnerContainer [

	super initializeInnerContainer.
	self innerContainer initializeFakeDataView
]

{ #category : #layout }
ToBarElement >> layoutConfigurator [

	^ ToBarLayoutConfigurator new
]

{ #category : #skin }
ToBarElement >> newRawSkin [ 

	^ ToBarElementSkin new
]

{ #category : #accessing }
ToBarElement >> nodeAutoDistribution [

	^ nodeAutoDistribution ifNil: [ nodeAutoDistribution := false ]
]

{ #category : #accessing }
ToBarElement >> nodeAutoDistribution: aBoolean [

	nodeAutoDistribution = aBoolean ifTrue: [ ^ self ].
	nodeAutoDistribution := aBoolean.
	self configureLayout
]

{ #category : #accessing }
ToBarElement >> nodeBuilder: aValuable [

	super nodeBuilder: aValuable.
	self notifyDataSourceChanged
]

{ #category : #accessing }
ToBarElement >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	super nodeFactory: aValuable.
	self notifyDataSourceChanged
]

{ #category : #accessing }
ToBarElement >> nodeHolderClass: aNodeHolderClass [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	super nodeHolderClass: aNodeHolderClass.
	self notifyDataSourceChanged
]

{ #category : #accessing }
ToBarElement >> nodeScrolling [

	^ nodeScrolling ifNil: [ nodeScrolling := false ]
]

{ #category : #accessing }
ToBarElement >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean.
	self configureLayout
]

{ #category : #accessing }
ToBarElement >> nodeWrapping [

	^ nodeWrapping ifNil: [ nodeWrapping := false ]
]

{ #category : #accessing }
ToBarElement >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	self configureLayout
]

{ #category : #layout }
ToBarElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #'t - orientable - orientation' }
ToBarElement >> vertical: aBoolean [

	super vertical: aBoolean.
	self configureLayout
]
