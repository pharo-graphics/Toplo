Class {
	#name : #ToInfiniteElement,
	#superclass : #OBlInfiniteElement,
	#traits : 'TOBlLayoutResizable + TToDressable + TToWorldElement + TToWidgetWithContextMenu',
	#classTraits : 'TOBlLayoutResizable classTrait + TToDressable classTrait + TToWorldElement classTrait + TToWidgetWithContextMenu classTrait',
	#instVars : [
		'nodeFactory',
		'clickLauncher',
		'selectedNodeFactory',
		'primarySelection'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #'selection events' }
ToInfiniteElement >> cherryPickIndex: anIndex [

	self primarySelection dispatchSelectionChangedAfter: [
		self primarySelection cherryPickIndex: anIndex ]
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
ToInfiniteElement >> defaultPrimarySelection [

	^ ToSelectionStrategy new infiniteElement: self
]

{ #category : #initialization }
ToInfiniteElement >> defaultSecondarySelection [

	^ ToSelectionModel new
]

{ #category : #'selection events' }
ToInfiniteElement >> deselectAll [

	self primarySelection dispatchSelectionChangedAfter: [
		self primarySelection deselectAll ]
	to: self
]

{ #category : #dispatching }
ToInfiniteElement >> dispatchChildAttached: anElement [
	
	super dispatchChildAttached: anElement
]

{ #category : #dispatching }
ToInfiniteElement >> dispatchChildDetached: anElement [
	
	super dispatchChildDetached: anElement
]

{ #category : #'selection events' }
ToInfiniteElement >> dispatchSelectionChangedAfter: aBlock [

	| prevIndexes currentIndexes |
	prevIndexes := self selectedIndexes copy.
	aBlock value.
	currentIndexes := self selectedIndexes.
	prevIndexes = currentIndexes ifTrue: [ ^ self ].
	self dispatchEvent: (ToInfiniteSelectionChangedEvent from: prevIndexes to: currentIndexes)
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

{ #category : #testing }
ToInfiniteElement >> hasSelection [

	^ self primarySelection isEmpty not
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
	primarySelection := self defaultPrimarySelection.
	self privateData: ToObservableCollection new.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	self initializeDresser
]

{ #category : #'selection events' }
ToInfiniteElement >> isSelectedAtIndex: anIndex [

	^ self primarySelection includes: anIndex
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

	self primarySelection
			offsetPositionForInsert: aStartPosition
			itemCount: anItemCount.
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
	self primarySelection
		offsetPositionForRemove: aStartPosition
		itemCount: anItemCount
]

{ #category : #'private - focus' }
ToInfiniteElement >> onGotFocus [ 


]

{ #category : #'private - focus' }
ToInfiniteElement >> onLostFocus [ 

]

{ #category : #accessing }
ToInfiniteElement >> primarySelection [

	^ primarySelection
]

{ #category : #'private - accessing' }
ToInfiniteElement >> privateData: aCollection [

	self primarySelection deselectAll.
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
ToInfiniteElement >> selectAll [

	self primarySelection dispatchSelectionChangedAfter: [
		self primarySelection selectAll ]
	to: self
]

{ #category : #'selection events' }
ToInfiniteElement >> selectIndex: anIndex [

	self primarySelection dispatchSelectionChangedAfter: [
		self primarySelection selectIndex: anIndex ]
	to: self
]

{ #category : #'selection events' }
ToInfiniteElement >> selectToIndex: anIndex [

	self primarySelection dispatchSelectionChangedAfter: [
		self primarySelection selectToIndex: anIndex ]
	to: self
]

{ #category : #accessing }
ToInfiniteElement >> selectedIndexes [ 

	^ self primarySelection selectedIndexes
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

	self hasFocus ifFalse: [
		self requestFocus.
		self hasSelection ifTrue: [ ^ self ] ].

	self primarySelection multipleSelectionModeDo: [
		event modifiers isShift ifTrue: [
			^ self selectToIndex: anAnnouncement holder layoutPosition ].
		event modifiers isPrimaryModifier ifTrue: [
			^ self cherryPickIndex: anAnnouncement holder layoutPosition ] ].

	self primarySelection atLeastMonoSelectionDo: [
		self selectIndex: anAnnouncement holder layoutPosition.
		self dispatchEvent: (ToInfiniteClickOnDataEvent new
				 index: anAnnouncement holder layoutPosition;
				 event: event;
				 yourself) ]
]

{ #category : #'selection events' }
ToInfiniteElement >> whenSecondarySelectionChangedAnnouncement: anAnnouncement [


]
