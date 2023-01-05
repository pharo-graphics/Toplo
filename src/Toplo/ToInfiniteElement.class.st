Class {
	#name : #ToInfiniteElement,
	#superclass : #OBlInfiniteElement,
	#traits : 'TOBlLayoutResizable + TToDressable + TToWorldElement',
	#classTraits : 'TOBlLayoutResizable classTrait + TToDressable classTrait + TToWorldElement classTrait',
	#instVars : [
		'selectionStrategy',
		'nodeFactory'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #initialization }
ToInfiniteElement >> defaultDataSource [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToInfiniteElement >> defaultLayout [

	^ OBlInfiniteLinearLayout new
]

{ #category : #initialization }
ToInfiniteElement >> defaultNodeFactory [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToInfiniteElement >> defaultSelectionStrategy [

	^ ToSelectionStrategy new dataSource: self dataSource.
]

{ #category : #'selection events' }
ToInfiniteElement >> dispatchSelectionChangedAfter: aBlock [

	| indexes |
	indexes := self selectedIndexes copy.
	aBlock value.
	self dispatchEvent: (ToSelectionChanged from: indexes to: self selectedIndexes)
]

{ #category : #initialization }
ToInfiniteElement >> holderClass [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToInfiniteElement >> initialize [ 

	super initialize.
	nodeFactory := self defaultNodeFactory.
	selectionStrategy := self defaultSelectionStrategy.
	self list: ToObservableCollection new.	
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	
	self initializeDresser 
]

{ #category : #accessing }
ToInfiniteElement >> list [

	^ dataSource list
]

{ #category : #accessing }
ToInfiniteElement >> list: aList [

	selectionStrategy clearSelection.
	dataSource list: aList

]

{ #category : #accessing }
ToInfiniteElement >> nodeFactory [

	^ nodeFactory 
]

{ #category : #accessing }
ToInfiniteElement >> nodeFactory: aValuable [

	nodeFactory := aValuable
]

{ #category : #'private - focus' }
ToInfiniteElement >> onGotFocus [ 

	'onGotFocus' traceCr
]

{ #category : #'private - focus' }
ToInfiniteElement >> onLostFocus [ 

	'onLostFocus' traceCr
]

{ #category : #private }
ToInfiniteElement >> scrollToIndex: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"
	
	self scrollToPosition: anIndex.
	
	"aWish smooth
		ifTrue: [ self listElement smoothScrollToPosition: aWish index ]
		ifFalse: [ self listElement scrollToPosition: aWish index ]"
]

{ #category : #accessing }
ToInfiniteElement >> selectedIndexes [ 

	^ self selectionStrategy selectedIndexes
]

{ #category : #accessing }
ToInfiniteElement >> selectionStrategy [

	^ selectionStrategy
]

{ #category : #'selection events' }
ToInfiniteElement >> whenClickOnNodeAnnouncement: anAnnouncement [

	| event |
	event := anAnnouncement event.
	event modifiers isShift ifTrue: [ 
		^ self dispatchSelectionChangedAfter: [ 
			  self selectionStrategy selectToIndex:
				  anAnnouncement holder layoutPosition ] ].
	event modifiers isPrimaryModifier ifTrue: [ 
		^ self dispatchSelectionChangedAfter: [ 
			  self selectionStrategy cherryPickIndex:
				  anAnnouncement holder layoutPosition ] ].
	self dispatchSelectionChangedAfter: [ 
		self selectionStrategy selectIndex:
			anAnnouncement holder layoutPosition ]
]
