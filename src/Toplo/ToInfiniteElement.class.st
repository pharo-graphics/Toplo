Class {
	#name : #ToInfiniteElement,
	#superclass : #OBlInfiniteElement,
	#traits : 'TOBlLayoutResizable + TToDressable + TToWorldElement + TToWidgetWithContextMenu',
	#classTraits : 'TOBlLayoutResizable classTrait + TToDressable classTrait + TToWorldElement classTrait + TToWidgetWithContextMenu classTrait',
	#instVars : [
		'nodeFactory',
		'clickLauncher',
		'selectedNodeFactory',
		'primarySelection',
		'secondarySelection'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #'selection mode' }
ToInfiniteElement >> beMultipleSelection [ 

	self primarySelection beMultipleSelection
]

{ #category : #'selection mode' }
ToInfiniteElement >> beSingleSelection [ 

	self primarySelection beSingleSelection
]

{ #category : #'selection mode' }
ToInfiniteElement >> beWithoutSelection [ 

	self primarySelection beWithoutSelection
]

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

{ #category : #'t - accessing context menu' }
ToInfiniteElement >> contextMenu [

	" specific version to pass the secondary selection as 2de argument "
	^ 	(self contextMenuFactory cull: self cull: self secondarySelection copy) widget: self; client: self; yourself

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
	prevIndexes := self primarySelectionIndexes copy.
	aBlock value.
	currentIndexes := self primarySelectionIndexes.
	prevIndexes = currentIndexes ifTrue: [ ^ self ].
	self dispatchEvent: (ToInfiniteSelectionChangedEvent from: prevIndexes to: currentIndexes)
]

{ #category : #'selection events' }
ToInfiniteElement >> dispatchStrongSelectionChanged [

	self terminateClickLauncher.
	self dispatchEvent: (ToStrongSelectionEvent indexes: self primarySelectionIndexes)
]

{ #category : #private }
ToInfiniteElement >> hasClickLauncher [

	^ clickLauncher notNil
]

{ #category : #testing }
ToInfiniteElement >> hasSelection [

	^ self primarySelection isNotEmpty
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
	secondarySelection := self defaultSecondarySelection.
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
ToInfiniteElement >> nodeAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
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

	| selectedAfter |
	
	" deselect items after "
	
	selectedAfter := self selectedIndexes select: [ :idx | idx >= aStartPosition ].
	selectedAfter do: [ :idx | self primarySelection deselectIndex: idx ].

	super
		offsetPositionRecordsForInsert: aStartPosition
		itemCount: anItemCount.

	" Have to wait for the layout done to update the selection decorations (that depends on items bounds) "
	self whenLayoutedDoOnce: [
		self primarySelection
			dispatchSelectionChangedAfter: [
				selectedAfter reverseDo: [ :idx |
					self primarySelection addToSelection: idx + anItemCount ] ]
			to: self ]
]

{ #category : #'private - commands' }
ToInfiniteElement >> offsetPositionRecordsForMove: aFromPosition to: aToPosition [

	super offsetPositionRecordsForMove: aFromPosition to: aToPosition
]

{ #category : #'private - commands' }
ToInfiniteElement >> offsetPositionRecordsForRemove: aStartPosition itemCount: anItemCount applyToPreLayout: applyToPreLayout [

	super
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: applyToPreLayout.

	self primarySelection
		dispatchSelectionChangedAfter: [
			self primarySelection
				offsetPositionForRemove: aStartPosition
				itemCount: anItemCount ]
		to: self
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

{ #category : #accessing }
ToInfiniteElement >> primarySelectionDo: aBlock [

	self primarySelectionIndexes ifEmpty: [ ^ self ].
	aBlock value: self primarySelection 
]

{ #category : #accessing }
ToInfiniteElement >> primarySelectionIndexes [ 

	^ self primarySelection selectedIndexes
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

{ #category : #accessing }
ToInfiniteElement >> secondarySelection [

	^ secondarySelection
]

{ #category : #accessing }
ToInfiniteElement >> secondarySelectionDo: aBlock [

	self secondarySelectionIndexes ifEmpty: [ ^ self ].
	aBlock value: self secondarySelection 
]

{ #category : #accessing }
ToInfiniteElement >> secondarySelectionIndexes [ 

	^ self secondarySelection selectedIndexes
]

{ #category : #'selection events' }
ToInfiniteElement >> selectAll [

	self primarySelection dispatchSelectionChangedAfter: [
		self primarySelection selectAll ]
	to: self
]

{ #category : #'selection events' }
ToInfiniteElement >> selectIndex: anIndex [

	self primarySelection
		dispatchSelectionChangedAfter: [ " ensure that the layout is computed before updating the selection "
			self primarySelection selectIndex: anIndex.
			self whenLayoutedDoOnce: [ self scrollToIndex: anIndex ] ]
		to: self
]

{ #category : #'selection events' }
ToInfiniteElement >> selectIndexes: aCollection [

	self primarySelection
		dispatchSelectionChangedAfter: [
			self primarySelection
				deselectAll;
				selectIndexes: aCollection.
			aCollection ifNotEmpty: [
				self requestLayout.
				self whenLayoutedDoOnce: [ self scrollToIndex: aCollection first ] ] ]
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

	^ self primarySelectionIndexes 
]

{ #category : #accessing }
ToInfiniteElement >> selectionDo: aBlock [

	self primarySelectionDo: aBlock

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
		self requestFocus ].

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
