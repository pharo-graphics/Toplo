Class {
	#name : #ToLinearBarInnerElement,
	#superclass : #ToTripletElement,
	#instVars : [
		'listElement',
		'dataSource',
		'dataSourceObserver',
		'dataSourceManager',
		'scrollable'
	],
	#category : #'Toplo-Widget-List-InnerLinearBar'
}

{ #category : #'instance creation' }
ToLinearBarInnerElement class >> onLinearBarElement: aLinearBarElement [

	^ self basicNew
		  listElement: aLinearBarElement;
		  initialize
]

{ #category : #adding }
ToLinearBarInnerElement >> addHolders: anArray [

	scrollable addHolders: anArray
]

{ #category : #initialization }
ToLinearBarInnerElement >> configureLayoutIn: aListElement [

	self isHorizontal
		ifTrue: [
			self hMatchParent.
			self vFitContent.
			self middleContainer constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ] ]
		ifFalse: [
			self vMatchParent.
			self hFitContent.
			self middleContainer constraintsDo: [ :c |
				c vertical matchParent.
				c horizontal fitContent ] ].

	scrollable configureLayoutIn: aListElement
]

{ #category : #accessing }
ToLinearBarInnerElement >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToLinearBarInnerElement >> dataSourceManager [

	^ dataSourceManager 
]

{ #category : #initialization }
ToLinearBarInnerElement >> defaultDataSource [ 

	^ listElement dataSource.
]

{ #category : #initialization }
ToLinearBarInnerElement >> defaultDataSourceManager [

	^ ToScrollableBarDataSourceManager new
		  innerLinearBarElement: self;
		  yourself
]

{ #category : #initialization }
ToLinearBarInnerElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"

	^ ToScrollableBarDataSourceObserver
]

{ #category : #initialization }
ToLinearBarInnerElement >> initialize [ 

	super initialize.
	self initializeDataSource.
	self id: #innerElement.
	scrollable := ToScrollableBarElement new.
	scrollable id: #scrollable.
	self middleElement: scrollable.
	self matchParent
]

{ #category : #initialization }
ToLinearBarInnerElement >> initializeDataSource [

	dataSource := self defaultDataSource.
	dataSource onAttached: self.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager
]

{ #category : #accessing }
ToLinearBarInnerElement >> listElement [

	^ listElement
]

{ #category : #accessing }
ToLinearBarInnerElement >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #'instance creation' }
ToLinearBarInnerElement >> newNodeHolderFromDataSource: aDataSource [

	^ self listElement nodeManager newNodeHolder
]

{ #category : #'t - infinite accessing' }
ToLinearBarInnerElement >> nodeContainer [

	^ self
]

{ #category : #'accessing - nodes' }
ToLinearBarInnerElement >> nodeGroupsSatisfying: aBlock [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  self nodesDo: [ :node |
			  (aBlock value: node)
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #enumerating }
ToLinearBarInnerElement >> nodesDo: aBlock [

	scrollable nodesDo: aBlock
]

{ #category : #'accessing - children' }
ToLinearBarInnerElement >> selectableNodeContainingGlobalPosition: aPoint [

	self nodesDo: [ :node |
		(node holder isSelectable and: [ node containsGlobalPoint: aPoint ])
			ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #'t - infinite accessing' }
ToLinearBarInnerElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"

	
]
