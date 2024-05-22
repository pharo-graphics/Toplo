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
ToBarElement >> checkVisibleNodes [ 

	self nodeContainer checkVisibleNodes 
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
	self nodeContainer configureLayoutIn: self.
	self checkVisibleNodes.
	self requestLayout
]

{ #category : #initialization }
ToBarElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToBarElement >> defaultEventHandler [

	^ ToListElementEventHandler new
]

{ #category : #initialization }
ToBarElement >> defaultNodeContainer [

	^ ToInnerBarElement onBarElement: self
]

{ #category : #initialization }
ToBarElement >> defaultNodeManagerClass [

	^ ToBarNodeManager 
]

{ #category : #accessing }
ToBarElement >> fakeDataItem: aDataItem [

	self nodeContainer fakeDataItem: aDataItem
]

{ #category : #accessing }
ToBarElement >> flowLineUniformWidth [

	^ flowLineUniformWidth
]

{ #category : #accessing }
ToBarElement >> flowLineUniformWidth: aBoolean [

	flowLineUniformWidth := aBoolean.
	self configureLayout.
	dataSource notifyChanged

]

{ #category : #'t - orientable - orientation' }
ToBarElement >> horizontal: aBoolean [

	super horizontal: aBoolean.
	self configureLayout
]

{ #category : #initialization }
ToBarElement >> initialize [

	super initialize.
	nodeWrapping := true.
	nodeScrolling := true.
	nodeAutoDistribution := false.
	flowLineUniformWidth := false.
	self installNodeContainer
]

{ #category : #initialization }
ToBarElement >> installNodeContainer [

	self configureLayout
]

{ #category : #accessing }
ToBarElement >> nodeAutoDistribution [

	^ nodeAutoDistribution
]

{ #category : #accessing }
ToBarElement >> nodeAutoDistribution: aBoolean [

	nodeAutoDistribution = aBoolean ifTrue: [ ^ self ].
	nodeAutoDistribution := aBoolean.
	self configureLayout
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
