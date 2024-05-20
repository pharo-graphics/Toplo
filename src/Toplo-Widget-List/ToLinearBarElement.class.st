Class {
	#name : #ToLinearBarElement,
	#superclass : #ToAbstractListElement,
	#instVars : [
		'nodeWrapping',
		'nodeScrolling',
		'nodeAutoDistribution'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToLinearBarElement >> configureLayout [

	self isHorizontal
		ifTrue: [
			self constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ] ]
		ifFalse: [
			self constraintsDo: [ :c |
				c vertical matchParent.
				c horizontal fitContent ] ].
	self nodeContainer configureLayoutIn: self
]

{ #category : #initialization }
ToLinearBarElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToLinearBarElement >> defaultEventHandler [

	^ ToListElementEventHandler new
]

{ #category : #initialization }
ToLinearBarElement >> defaultNodeContainer [

	^ ToLinearBarInnerElement onLinearBarElement: self
]

{ #category : #accessing }
ToLinearBarElement >> fakeDataItem: aDataItem [

	self nodeContainer fakeDataItem: aDataItem
]

{ #category : #'t - orientable - orientation' }
ToLinearBarElement >> horizontal: aBoolean [

	super horizontal: aBoolean.
	self configureLayout
]

{ #category : #initialization }
ToLinearBarElement >> initialize [

	super initialize.
	nodeWrapping := true.
	nodeScrolling := true.
	nodeAutoDistribution := false.
	self installNodeContainer  

]

{ #category : #initialization }
ToLinearBarElement >> installNodeContainer [

	self configureLayout
]

{ #category : #accessing }
ToLinearBarElement >> nodeAutoDistribution [

	^ nodeAutoDistribution
]

{ #category : #accessing }
ToLinearBarElement >> nodeAutoDistribution: aBoolean [

	nodeAutoDistribution := aBoolean.
	self configureLayout
]

{ #category : #accessing }
ToLinearBarElement >> nodeScrolling [

	^ nodeScrolling 
]

{ #category : #accessing }
ToLinearBarElement >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean.
	self configureLayout
]

{ #category : #accessing }
ToLinearBarElement >> nodeWrapping [

	^ nodeWrapping 
]

{ #category : #accessing }
ToLinearBarElement >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	self configureLayout
]

{ #category : #'t - orientable - orientation' }
ToLinearBarElement >> vertical: aBoolean [

	super vertical: aBoolean.
	self configureLayout
]
