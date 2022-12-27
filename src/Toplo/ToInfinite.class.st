Class {
	#name : #ToInfinite,
	#superclass : #OBlInfiniteElement,
	#instVars : [
		'dataToElementStencyl',
		'list'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #adding }
ToInfinite >> addAll: aCollection [

	self list addAll: aCollection 
]

{ #category : #accessing }
ToInfinite >> dataToElementStencyl [

	^ dataToElementStencyl
]

{ #category : #accessing }
ToInfinite >> dataToElementStencyl: aBlock [

	dataToElementStencyl := aBlock
]

{ #category : #initialization }
ToInfinite >> defaultLayout [
	^ OBlInfiniteLinearLayout new
]

{ #category : #initialization }
ToInfinite >> initialize [

	super initialize.
	list := ToObservableCollection new.
	
	list whenAddChangeDo: [ :ann | self dataSource notifyItemsInserted: ann interval ]. 
	list whenRemoveChangeDo: [ :ann | self dataSource notifyItemsRemoved: ann interval ]. 
	list whenUpdateChangeDo: [ :ann | self dataSource notifyItemsChanged: ann interval ]. 
		
	self dataSource: (ToInfiniteDataSource new list: list).
	dataToElementStencyl := [ :d | d asElement ].
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
