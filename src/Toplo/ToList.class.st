Class {
	#name : #ToList,
	#superclass : #OBlInfiniteElement,
	#traits : 'TOBlLayoutResizable + TToDressable',
	#classTraits : 'TOBlLayoutResizable classTrait + TToDressable classTrait',
	#instVars : [
		'nodeFactory',
		'selectionStrategy'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToList >> defaultDataSource [

	^ ToListDataSource new
]

{ #category : #'t - initialization dresser' }
ToList >> defaultDresser [ 

	^ ToListDresser new
]

{ #category : #initialization }
ToList >> defaultLayout [

	^ OBlInfiniteLinearLayout new
]

{ #category : #initialization }
ToList >> holderClass [

	^ ToListNodeHolder 
]

{ #category : #initialization }
ToList >> initialize [ 

	super initialize.
	nodeFactory := [ :d | ToLabeledNode new labelText: d ].
	selectionStrategy := ToSelectionStrategy new dataSource: self dataSource.
	self list: ToObservableCollection new.	
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	self initializeDresser 
]

{ #category : #accessing }
ToList >> list [

	^ dataSource list
]

{ #category : #accessing }
ToList >> list: aList [

	selectionStrategy clearSelection.
	dataSource list: aList

]

{ #category : #accessing }
ToList >> nodeFactory [

	^ nodeFactory 
]

{ #category : #accessing }
ToList >> nodeFactory: aValuable [

	nodeFactory := aValuable
]

{ #category : #private }
ToList >> scrollToIndex: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"
	
	self scrollToPosition: anIndex.
	
	"aWish smooth
		ifTrue: [ self listElement smoothScrollToPosition: aWish index ]
		ifFalse: [ self listElement scrollToPosition: aWish index ]"
]

{ #category : #accessing }
ToList >> selectionStrategy [

	^ selectionStrategy
]

{ #category : #'selection events' }
ToList >> whenClickOnNodeAnnouncement: anAnnouncement [

	self selectionStrategy selectIndex: anAnnouncement holder layoutPosition
]
