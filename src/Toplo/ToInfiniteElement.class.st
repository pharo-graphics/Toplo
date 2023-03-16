Class {
	#name : #ToInfiniteElement,
	#superclass : #OBlInfiniteElement,
	#traits : 'TOBlLayoutResizable + TToDressable + TToWorldElement + TToWidgetWithContextMenu',
	#classTraits : 'TOBlLayoutResizable classTrait + TToDressable classTrait + TToWorldElement classTrait + TToWidgetWithContextMenu classTrait',
	#instVars : [
		'selectionStrategy',
		'nodeFactory',
		'clickLauncher'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #'selection events' }
ToInfiniteElement >> cherryPickIndex: anIndex [

	self selectionStrategy dispatchSelectionChangedAfter: [
		self selectionStrategy cherryPickIndex: anIndex ]
		to: self
]

{ #category : #'selection events' }
ToInfiniteElement >> clearSelection [

	self selectionStrategy dispatchSelectionChangedAfter: [
		self selectionStrategy clearSelection ]
	to: self
]

{ #category : #private }
ToInfiniteElement >> clickLauncher [

	^ clickLauncher

]

{ #category : #private }
ToInfiniteElement >> clickLauncher: aProcessOrNil [

	clickLauncher := aProcessOrNil

]

{ #category : #accessing }
ToInfiniteElement >> client [

	^ self
]

{ #category : #accessing }
ToInfiniteElement >> data [

	^ dataSource list
]

{ #category : #initialization }
ToInfiniteElement >> defaultDataSource [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToInfiniteElement >> defaultLayout [

	^ OBlInfiniteLinearLayout new
]

{ #category : #initialization }
ToInfiniteElement >> defaultListNodeFactory [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToInfiniteElement >> defaultSelectionStrategy [

	^ ToSelectionStrategy new dataSource: self dataSource.
]

{ #category : #dispatching }
ToInfiniteElement >> dispatchChildAttached: anElement [
	
	super dispatchChildAttached: anElement.
	anElement dresserDo: [ :d | d onElementAttached: anElement inInfinite: self]
]

{ #category : #dispatching }
ToInfiniteElement >> dispatchChildDetached: anElement [
	
	super dispatchChildDetached: anElement.
	anElement dresserDo: [ :d | d onElementDetached: anElement inInfinite: self ]
]

{ #category : #'selection events' }
ToInfiniteElement >> dispatchNodeHovered: aNodeHolder after: aBlock [

	aBlock value.
	self dispatchEvent: (ToInfiniteNodeHoveredEvent new holder: aNodeHolder; yourself)
]

{ #category : #'selection events' }
ToInfiniteElement >> dispatchNodeLeaved: aNodeHolder after: aBlock [

	aBlock value.
	self dispatchEvent: (ToInfiniteNodeLeavedEvent new holder: aNodeHolder; yourself)
]

{ #category : #'selection events' }
ToInfiniteElement >> dispatchSelectionChangedAfter: aBlock [

	| indexes |
	indexes := self selectedIndexes copy.
	aBlock value.
	self dispatchEvent: (ToInfiniteSelectionChangedEvent from: indexes to: self selectedIndexes)
]

{ #category : #'selection events' }
ToInfiniteElement >> dispatchStrongSelectionChanged [

	self terminateClickLauncher.
	self dispatchEvent: (ToStrongSelectionEvent indexes: self selectedIndexes)
]

{ #category : #private }
ToInfiniteElement >> hasClickLauncher [

	^ clickLauncher notNil
]

{ #category : #initialization }
ToInfiniteElement >> holderClass [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToInfiniteElement >> initialize [

	self class initializeSlots: self.
	super initialize.
	self nodeFactory: self defaultListNodeFactory.
	selectionStrategy := self defaultSelectionStrategy.
	self privateData: ToObservableCollection new.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	self initializeDresser
]

{ #category : #accessing }
ToInfiniteElement >> list [

	self
		deprecated: 'Please use #data instead.'
		transformWith:
			'`@receiver list'
				-> '`@receiver data'.

	^ self data

]

{ #category : #accessing }
ToInfiniteElement >> list: aList [

	self
		deprecated: 'Please use #privateData: instead.'
		transformWith:
			'`@receiver list: `@statements1'
				-> '`@receiver privateData: `@statements1'.

	self privateData: aList

]

{ #category : #accessing }
ToInfiniteElement >> nodeFactory [

	^ nodeFactory 
]

{ #category : #accessing }
ToInfiniteElement >> nodeFactory: aNodeFactory [

	nodeFactory := aNodeFactory asToDataToElementConverter
]

{ #category : #'private - commands' }
ToInfiniteElement >> offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount [

	super
		offsetPositionRecordsForInsert: aStartPosition
		itemCount: anItemCount.
	self selectionStrategy
		offsetPositionForInsert: aStartPosition
		itemCount: anItemCount
]

{ #category : #'private - commands' }
ToInfiniteElement >> offsetPositionRecordsForMove: aFromPosition to: aToPosition [

	super offsetPositionRecordsForMove: aFromPosition to: aToPosition
]

{ #category : #removing }
ToInfiniteElement >> offsetPositionRecordsForRemove: aStartPosition itemCount: anItemCount applyToPreLayout: applyToPreLayout [

	super
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: applyToPreLayout.
	self selectionStrategy
		offsetPositionForRemove: aStartPosition
		itemCount: anItemCount
]

{ #category : #'private - focus' }
ToInfiniteElement >> onGotFocus [ 


]

{ #category : #'private - focus' }
ToInfiniteElement >> onLostFocus [ 

]

{ #category : #'private - accessing' }
ToInfiniteElement >> privateData: aCollection [

	selectionStrategy clearSelection.
	dataSource list: aCollection
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

{ #category : #'selection events' }
ToInfiniteElement >> selectIndex: anIndex [

	self selectionStrategy dispatchSelectionChangedAfter: [
		self selectionStrategy selectIndex: anIndex ]
	to: self
]

{ #category : #'selection events' }
ToInfiniteElement >> selectToIndex: anIndex [

	self selectionStrategy dispatchSelectionChangedAfter: [
		self selectionStrategy selectToIndex: anIndex ]
	to: self
]

{ #category : #accessing }
ToInfiniteElement >> selectedIndexes [ 

	^ self selectionStrategy selectedIndexes
]

{ #category : #accessing }
ToInfiniteElement >> selectionStrategy [

	^ selectionStrategy
]

{ #category : #private }
ToInfiniteElement >> terminateClickLauncher [

	clickLauncher ifNotNil: #terminate.
	clickLauncher := nil.
]

{ #category : #'selection events' }
ToInfiniteElement >> whenClickOnNodeAnnouncement: anAnnouncement [

	| event |
	event := anAnnouncement event.
	event modifiers isShift ifTrue: [
		^ self selectToIndex: anAnnouncement holder layoutPosition ].
	event modifiers isPrimaryModifier ifTrue: [
		^ self cherryPickIndex: anAnnouncement holder layoutPosition ].
	self selectIndex: anAnnouncement holder layoutPosition.
	self dispatchEvent: (ToInfiniteClickOnDataEvent new
			 index: anAnnouncement holder layoutPosition;
			 event: event;
			 yourself)
]
