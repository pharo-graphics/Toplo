Class {
	#name : #ToBarElement,
	#superclass : #ToAbstractListElement,
	#instVars : [
		'nodeWrapping',
		'nodeScrolling',
		'nodeAutoDistribution',
		'flowLineUniformWidth'
	],
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #layout }
ToBarElement >> checkFullyVisibleNodes [ 

	self innerContainer checkFullyVisibleNodes 
]

{ #category : #layout }
ToBarElement >> configureLayout [

	self innerContainer configureLayoutIn: self
]

{ #category : #initialization }
ToBarElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToBarElement >> defaultEventHandler [

	^ ToBarElementEventHandler new
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
	self uninstallFakeNode.
	self installFakeNode.
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

{ #category : #initialization }
ToBarElement >> initialize [

	super initialize.
	selectionMode option
		grouped: false;
		beneath: true;
		triggerSelectionState: true.
	contextMenuSelectionMode option
		grouped: false;
		beneath: false.
	self matchParent.
	self configureLayout
]

{ #category : #initialization }
ToBarElement >> initializeInnerContainer [

	super initializeInnerContainer.
	self installFakeNode
]

{ #category : #initialization }
ToBarElement >> installFakeNode [

	self innerContainer installFakeNode
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
	" notify dataSource changed to renew all nodes "
	self notifyDataSourceChanged.
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

	^ nodeWrapping ifNil: [ nodeWrapping := true ]
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

{ #category : #initialization }
ToBarElement >> uninstallFakeNode [

	self innerContainer uninstallFakeNode
]
