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
ToLinearBarElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToLinearBarElement >> defaultEventHandler [

	^ ToListElementEventHandler new
]

{ #category : #initialization }
ToLinearBarElement >> defaultNodeContainer [

	^ ToScrollableBarElement onLinearBarElement: self
]

{ #category : #accessing }
ToLinearBarElement >> fakeDataItem: aDataItem [

	self nodeContainer fakeDataItem: aDataItem
]

{ #category : #initialization }
ToLinearBarElement >> initialize [

	super initialize.
	nodeWrapping := true.
	nodeScrolling := false.
	nodeAutoDistribution := false.

]

{ #category : #initialization }
ToLinearBarElement >> installNodeContainer [

	self nodeContainer configurateLayout
]

{ #category : #accessing }
ToLinearBarElement >> nodeAutoDistribution [

	^ nodeAutoDistribution
]

{ #category : #accessing }
ToLinearBarElement >> nodeAutoDistribution: aBoolean [

	nodeAutoDistribution := aBoolean.
	self nodeContainer configurateLayout
]

{ #category : #accessing }
ToLinearBarElement >> nodeScrolling [

	^ nodeScrolling 
]

{ #category : #accessing }
ToLinearBarElement >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean.
	self nodeContainer configurateLayout
]

{ #category : #accessing }
ToLinearBarElement >> nodeWrapping [

	^ nodeWrapping 
]

{ #category : #accessing }
ToLinearBarElement >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	self nodeContainer configurateLayout
]
