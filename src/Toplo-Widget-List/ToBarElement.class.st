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

{ #category : #layout }
ToBarElement >> checkFullyVisibleNodes [ 

	self innerContainer checkFullyVisibleNodes 
]

{ #category : #initialization }
ToBarElement >> configureLayout [

	self isHorizontal
		ifTrue: [
			self constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ] ]
		ifFalse: [
			self constraintsDo: [ :c |
				c vertical matchParent.
				c horizontal fitContent ] ].
	self innerContainer configureLayout.
	self checkFullyVisibleNodes
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
ToBarElement >> flowLineUniformWidth [

	^ flowLineUniformWidth
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
	selectionMode beneathOption: ToListSelectionOption separate.
	selectionMode overOption: ToListSelectionOption none.
	nodeWrapping := true.
	nodeScrolling := false.
	nodeAutoDistribution := false.
	flowLineUniformWidth := false.
	self configureLayout
]

{ #category : #initialization }
ToBarElement >> initializeInnerContainer [

	super initializeInnerContainer.
	self innerContainer installFakeDataView
]

{ #category : #accessing }
ToBarElement >> nodeAutoDistribution [

	^ nodeAutoDistribution ifNil: [ nodeAutoDistribution := false ]
]

{ #category : #accessing }
ToBarElement >> nodeAutoDistribution: aBoolean [

	nodeAutoDistribution = aBoolean ifTrue: [ ^ self ].
	nodeAutoDistribution := aBoolean.
	self configureLayout.
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

	^ nodeScrolling 
]

{ #category : #accessing }
ToBarElement >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean.
	self configureLayout
]

{ #category : #accessing }
ToBarElement >> nodeWrapping [

	^ nodeWrapping 
]

{ #category : #accessing }
ToBarElement >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	self configureLayout
]

{ #category : #'t - orientable - orientation' }
ToBarElement >> vertical: aBoolean [

	super vertical: aBoolean.
	self configureLayout
]
