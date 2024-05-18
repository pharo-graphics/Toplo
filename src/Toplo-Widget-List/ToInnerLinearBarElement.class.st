Class {
	#name : #ToInnerLinearBarElement,
	#superclass : #BlElement,
	#traits : 'TBlLayoutResizable',
	#classTraits : 'TBlLayoutResizable classTrait',
	#instVars : [
		'dataSource',
		'linearBarElement',
		'dataSourceObserver',
		'dataSourceManager'
	],
	#category : #'Toplo-Widget-List-InnerLinearBar'
}

{ #category : #'instance creation' }
ToInnerLinearBarElement class >> onLinearBarElement: aLinearBarElement [

	^ self basicNew
		  linearBarElement: aLinearBarElement;
		  initialize
]

{ #category : #accessing }
ToInnerLinearBarElement >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToInnerLinearBarElement >> dataSourceManager [

	^ dataSourceManager 
]

{ #category : #initialization }
ToInnerLinearBarElement >> defaultDataSource [ 

	^ linearBarElement dataSource.
]

{ #category : #initialization }
ToInnerLinearBarElement >> defaultDataSourceManager [

	^ ToInnerLinearBarDataSourceManager new
]

{ #category : #initialization }
ToInnerLinearBarElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"

	^ ToInnerLinearBarDataSourceObserver
]

{ #category : #initialization }
ToInnerLinearBarElement >> defaultLayout [

	^ ToInnerLinearBarLayout new
]

{ #category : #initialization }
ToInnerLinearBarElement >> initialize [ 

	super initialize.
	self background: (Color yellow alpha: 0.2).
	self layout: self defaultLayout.
	self initializeDataSource.
	self matchParent
]

{ #category : #initialization }
ToInnerLinearBarElement >> initializeDataSource [

	dataSource := self defaultDataSource.
	dataSource onAttached: self.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager
]

{ #category : #accessing }
ToInnerLinearBarElement >> linearBarElement [

	^ linearBarElement
]

{ #category : #accessing }
ToInnerLinearBarElement >> linearBarElement: anObject [

	linearBarElement := anObject
]

{ #category : #'t - infinite accessing' }
ToInnerLinearBarElement >> nodeContainer [

	^ self
]

{ #category : #'t  - layout resizeable' }
ToInnerLinearBarElement >> resizableConstraintsDo: aBlock [
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

{ #category : #'t - infinite accessing' }
ToInnerLinearBarElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"

	
]
