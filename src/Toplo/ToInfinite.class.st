Class {
	#name : #ToInfinite,
	#superclass : #OBlInfiniteElement,
	#instVars : [
		'list',
		'holderFactory',
		'dataSourceClass'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #adding }
ToInfinite >> addAll: aCollection [

	self list addAll: aCollection 
]

{ #category : #accessing }
ToInfinite >> dataSourceClass [ 

	^ dataSourceClass 
]

{ #category : #accessing }
ToInfinite >> dataSourceClass: aDataSourceClass [

	dataSourceClass := aDataSourceClass
]

{ #category : #initialization }
ToInfinite >> defaultDataSourceClass [

	^ ToInfiniteDataSource 
]

{ #category : #initialization }
ToInfinite >> defaultLayout [
	^ OBlInfiniteLinearLayout new
]

{ #category : #accessing }
ToInfinite >> holderFactory [

	^ holderFactory 
]

{ #category : #accessing }
ToInfinite >> holderFactory: aValuable [

	holderFactory := aValuable
]

{ #category : #initialization }
ToInfinite >> initialize [

	super initialize.
	list := ToObservableCollection new.
	dataSourceClass := self defaultDataSourceClass.
	
	list whenAddChangeDo: [ :ann | self dataSource notifyItemsInserted: ann interval ]. 
	list whenRemoveChangeDo: [ :ann | self dataSource notifyItemsRemoved: ann interval ]. 
	list whenUpdateChangeDo: [ :ann | self dataSource notifyItemsChanged: ann interval ]. 
		
	self dataSource: (self dataSourceClass new list: list).
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #accessing }
ToInfinite >> list [

	^ list
]

{ #category : #accessing }
ToInfinite >> list: aList [

	dataSource list: aList
]
