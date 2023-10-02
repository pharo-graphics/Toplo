Class {
	#name : #ToInfiniteElement,
	#superclass : #BlInfiniteElement,
	#traits : 'TToResizable + TToWidgetWithContextMenu',
	#classTraits : 'TToResizable classTrait + TToWidgetWithContextMenu classTrait',
	#instVars : [
		'nodeFactory',
		'clickLauncher',
		'primarySelection',
		'secondarySelection',
		'keepSelectionOnFocused',
		'shortcuts'
	],
	#category : #'Toplo-Widget-List-infinite'
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
		to: self.
	self fireEvent: (ToInfiniteNodeSelectedEvent new index: anIndex)
]

{ #category : #private }
ToInfiniteElement >> clickLauncher: aProcessOrNil [

	clickLauncher := aProcessOrNil

]

{ #category : #accessing }
ToInfiniteElement >> client [

	^ self
]

{ #category : #'t - widget with context menu - accessing' }
ToInfiniteElement >> contextMenu [

	" specific version to pass the secondary selection as 2de argument "
	^ 	(self contextMenuFactory cull: self cull: self secondarySelection copy) widget: self; client: self; yourself

]

{ #category : #accessing }
ToInfiniteElement >> data [

	^ dataSource data
]

{ #category : #initialization }
ToInfiniteElement >> defaultDataSource [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToInfiniteElement >> defaultHolderFactory [

	^ [ :infinite | self holderClass new infiniteElement: infinite ] 
]

{ #category : #initialization }
ToInfiniteElement >> defaultLayout [

	^ BlInfiniteLinearLayout new
]

{ #category : #initialization }
ToInfiniteElement >> defaultListNodeFactory [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToInfiniteElement >> defaultPrimarySelection [

	^ ToListSelectionStrategy new infiniteElement: self
]

{ #category : #initialization }
ToInfiniteElement >> defaultSecondarySelection [

	^ ToListSelectionModel new
]

{ #category : #'selection events' }
ToInfiniteElement >> deselectAll [

	self primarySelection dispatchSelectionChangedAfter: [
		self primarySelection deselectAll ]
	to: self
]

{ #category : #'selection events' }
ToInfiniteElement >> deselectIndex: anIndex [

	self primarySelection
		dispatchSelectionChangedAfter: [ 
			" ensure that the layout is computed before updating the selection "
			self primarySelection deselectIndex: anIndex ]
		to: self
]

{ #category : #'as yet unclassified' }
ToInfiniteElement >> disableScrolledEvent [

	self eventDispatcher disableEventType: BlMouseWheelEvent 
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
	self dispatchEvent: (ToListStrongSelectionEvent indexes: self primarySelectionIndexes)
]

{ #category : #'as yet unclassified' }
ToInfiniteElement >> enableScrolledEvent [

	self eventDispatcher enableEventType: BlMouseWheelEvent  
]

{ #category : #'selection events' }
ToInfiniteElement >> ensureSelectIndex: anIndex [

	self selectedIndex = anIndex ifFalse: [ self selectIndex: anIndex ]
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

{ #category : #'t - infinite accessing' }
ToInfiniteElement >> infinite [ 

	^ self
]

{ #category : #initialization }
ToInfiniteElement >> initialize [

	self class initializeSlots: self.
	super initialize.
	
	primarySelection := self defaultPrimarySelection.
	secondarySelection := self defaultSecondarySelection.
	self privateData: ToObservableCollection new.
	
	self primarySelection whenModeChangedDo: [
		self uninstallShortcuts.
		self installShortcuts ].
	self installShortcuts.
	
	self preserveSelectionOnFocused: self preserveSelectionOnFocusedByDefault.
	self nodeFactory: self defaultListNodeFactory.
	self matchParent
]

{ #category : #initialization }
ToInfiniteElement >> installShortcuts [

	shortcuts := self primarySelection shortcutsIn: self.
	shortcuts do: [ :s | self addShortcut: s ]
]

{ #category : #'selection events' }
ToInfiniteElement >> isSelectedAtIndex: anIndex [

	^ self primarySelection includes: anIndex
]

{ #category : #accessing }
ToInfiniteElement >> keepSelectionOnFocused [

	^ keepSelectionOnFocused
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

{ #category : #'instance creation' }
ToInfiniteElement >> newElementHolderFromDataSource: aDataSource [

	^ self holderClass new infiniteElement: self
]

{ #category : #accessing }
ToInfiniteElement >> nodeAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #initialization }
ToInfiniteElement >> nodeClass [

	^ self subclassResponsibility 
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

	self whenLayoutedDoOnce: [ 
		self primarySelection
			dispatchSelectionChangedAfter: [
				self primarySelection
					offsetPositionForRemove: aStartPosition
					itemCount: anItemCount ]
			to: self ]
]

{ #category : #'private - focus' }
ToInfiniteElement >> onGotFocus [ 


]

{ #category : #'private - focus' }
ToInfiniteElement >> onLostFocus [ 

]

{ #category : #accessing }
ToInfiniteElement >> preserveSelectionOnFocused: aBoolean [

	keepSelectionOnFocused := aBoolean
]

{ #category : #initialization }
ToInfiniteElement >> preserveSelectionOnFocusedByDefault [

	^ true
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
	dataSource data: aCollection
]

{ #category : #'t - layout resizeable' }
ToInfiniteElement >> resizableConstraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	
	Can be basically defined with #constraintsDo: aBlock.
	
	Introduced a an explicit requirement to let user
	implement additional actions when resizing is changed
	
	"
	self constraintsDo: aBlock
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

{ #category : #private }
ToInfiniteElement >> scrollToIndexAtTop: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"
	"As a result, item at anIndex is positionned at the top of the listElement"

	self scrollToPosition: anIndex offset: self layout computeExtraLayoutSpace y.
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
ToInfiniteElement >> selectAndScrollTo: anIndex [

	self primarySelection selectIndex: anIndex.
	self scrollToIndex: anIndex
]

{ #category : #'selection events' }
ToInfiniteElement >> selectIndex: anIndex [


	self primarySelection
		dispatchSelectionChangedAfter: [ 
			self primarySelection selectIndex: anIndex.
			self whenLayoutedDoOnce: [ self scrollToIndex: anIndex ] ]
		to: self.
	self fireEvent: (ToInfiniteNodeSelectedEvent new index: anIndex)
]

{ #category : #'selection events' }
ToInfiniteElement >> selectIndexes: aCollection [

	self primarySelection
		dispatchSelectionChangedAfter: [
			self primarySelection deselectAll.
			aCollection ifNotEmpty: [
				self whenLayoutedDoOnce: [ self scrollToIndexAtTop:  aCollection first ] ].
			self primarySelection selectIndexes: aCollection.
			self requestLayout ]
		to: self
]

{ #category : #'selection events' }
ToInfiniteElement >> selectToIndex: anIndex [

	self primarySelection dispatchSelectionChangedAfter: [
		self primarySelection selectToIndex: anIndex ]
	to: self.
	self fireEvent: (ToInfiniteNodeSelectedEvent new index: anIndex)
]

{ #category : #accessing }
ToInfiniteElement >> selectedIndex [

	^ self primarySelection selectedIndex
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

{ #category : #initialization }
ToInfiniteElement >> uninstallShortcuts [

	shortcuts do: [ :s | self removeShortcut: s ].
	shortcuts := nil
]

{ #category : #dispatching }
ToInfiniteElement >> whenChildAttachedDo: aBlock [

	self when: BlInfiniteElementAttachedEvent do: aBlock
]

{ #category : #dispatching }
ToInfiniteElement >> whenChildDetachedDo: aBlock [

	self when: BlInfiniteElementDetachedEvent do: aBlock
]

{ #category : #'selection events' }
ToInfiniteElement >> whenClickOnNodeEvent: anEvent [

	| originalEvent |
	originalEvent := anEvent event.

	self hasFocus ifFalse: [	self requestFocus ].

	self primarySelection multipleSelectionModeDo: [
		originalEvent modifiers isShift ifTrue: [
			^ self selectToIndex: anEvent holder layoutPosition ].
		originalEvent modifiers isPrimaryModifier ifTrue: [
			^ self cherryPickIndex: anEvent holder layoutPosition ] ].

	self primarySelection atLeastMonoSelectionDo: [
		self selectIndex: anEvent holder layoutPosition ]
]
