Class {
	#name : #ToInfiniteElement,
	#superclass : #BlInfiniteElement,
	#traits : 'TBlLayoutResizable',
	#classTraits : 'TBlLayoutResizable classTrait',
	#instVars : [
		'clickLauncher',
		'shortcuts',
		'nodeBuilder',
		'preserveSelectionOnFocused',
		'nodeClass',
		'selectionStrategy'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'selection mode' }
ToInfiniteElement >> beMultipleSelection [

	self selection beMultipleSelectionIn: self
]

{ #category : #'selection mode' }
ToInfiniteElement >> beSingleSelection [

	self primarySelection beSingleSelectionIn: self
]

{ #category : #'selection mode' }
ToInfiniteElement >> beWithoutSelection [

	self primarySelection beWithoutSelectionIn: self
]

{ #category : #'selection events' }
ToInfiniteElement >> cherryPickIndex: anIndex [

	self dispatchSelectionChangedAfter: [
		self primarySelection cherryPickIndex: anIndex ]
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

	^ dataSource data
]

{ #category : #initialization }
ToInfiniteElement >> defaultDataSource [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToInfiniteElement >> defaultLayout [

	^ BlInfiniteLinearLayout new
]

{ #category : #initialization }
ToInfiniteElement >> defaultMouseScrollEventHandler [

	^ BlInfiniteMouseScrollListener new
		  restrictedByOrientation: true;
		  yourself
]

{ #category : #initialization }
ToInfiniteElement >> defaultNodeBuilder [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToInfiniteElement >> defaultSelectionStrategy [

	^ ToListSelectionStrategy new 
]

{ #category : #'selection events' }
ToInfiniteElement >> deselectAll [

	self dispatchSelectionChangedAfter: [
		self primarySelection deselectAll ]
]

{ #category : #'selection events' }
ToInfiniteElement >> deselectIndex: anIndex [

	self dispatchSelectionChangedAfter: [
		self primarySelection deselectIndex: anIndex ]
]

{ #category : #'scrolled event' }
ToInfiniteElement >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #'selection events' }
ToInfiniteElement >> dispatchSelectionChangedAfter: aBlock [

	| prevIndexes currentIndexes event |
	prevIndexes := self primarySelectionIndexes copy.
	aBlock value.
	currentIndexes := self primarySelectionIndexes.
	prevIndexes := prevIndexes reject: [ :idx |
		               currentIndexes includes: idx ].
	prevIndexes = currentIndexes ifTrue: [ ^ self ].
	event := ToInfiniteSelectionChangedEvent
		         previousIndexes: prevIndexes
		         currentIndexes: currentIndexes.
	self dispatchEvent: event
]

{ #category : #'selection events' }
ToInfiniteElement >> dispatchStrongSelectionChanged [

	self terminateClickLauncher.
	self dispatchEvent: (ToListStrongSelectionEvent indexes: self primarySelectionIndexes)
]

{ #category : #'scrolled event' }
ToInfiniteElement >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent 
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
	self skinStateGeneratorClass ifNotNil: [ :cls |
		self addEventHandler: cls new ].
	selectionStrategy := self defaultSelectionStrategy.
	selectionStrategy onInstalledIn: self.
	self privateData: ToObservableCollection new.
	self installShortcuts.
	
	self preserveSelectionOnFocused: self preserveSelectionOnFocusedByDefault.
	self nodeBuilder: self defaultNodeBuilder.
	self matchParent
]

{ #category : #'shortcuts installation' }
ToInfiniteElement >> installShortcuts [

	shortcuts := self primarySelection shortcutsIn: self.
	shortcuts do: [ :s | self addShortcut: s ]
]

{ #category : #'selection events' }
ToInfiniteElement >> isSelectedAtIndex: anIndex [

	^ self primarySelection includes: anIndex
]

{ #category : #'instance creation' }
ToInfiniteElement >> newListNodeHolderFromDataSource: aDataSource [

	^ self holderClass new infiniteElement: self
]

{ #category : #accessing }
ToInfiniteElement >> nodeAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. 
	Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #accessing }
ToInfiniteElement >> nodeBuilder [

	"aValuable takes 2 args: first, the ToNode to build and second, the data"
	^ nodeBuilder 
]

{ #category : #accessing }
ToInfiniteElement >> nodeBuilder: aValuable [

	"aValuable takes 2 args: first, the ToNode to build and second, its holder in the list element "
	nodeBuilder := aValuable
]

{ #category : #initialization }
ToInfiniteElement >> nodeClass [

	^ nodeClass ifNil: [ nodeClass := ToListNode ]
]

{ #category : #initialization }
ToInfiniteElement >> nodeClass: aNodeClass [

	nodeClass := aNodeClass
]

{ #category : #'private - commands' }
ToInfiniteElement >> offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount [

	| selectedAfter |
	" deselect items after "
	selectedAfter := self selectedIndexes select: [ :idx |
		                 idx >= aStartPosition ].
	selectedAfter do: [ :idx | self primarySelection deselectIndex: idx ].

	super
		offsetPositionRecordsForInsert: aStartPosition
		itemCount: anItemCount.

	self dispatchSelectionChangedAfter: [
		selectedAfter reverseDo: [ :idx |
			self primarySelection addToSelection: idx + anItemCount ] ]
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

	self dispatchSelectionChangedAfter: [
		self primarySelection
			offsetPositionForRemove: aStartPosition
			itemCount: anItemCount ]
]

{ #category : #'selection strategy hooks' }
ToInfiniteElement >> onAddSelectionIndex: anIndex [
]

{ #category : #'selection strategy hooks' }
ToInfiniteElement >> onRemoveAllSelectionIndexes: aCollection [
]

{ #category : #'selection strategy hooks' }
ToInfiniteElement >> onRemoveSelectionIndex: anIndex [
]

{ #category : #'selection strategy hooks' }
ToInfiniteElement >> onSelectAll [
]

{ #category : #'selection mode' }
ToInfiniteElement >> onSelectionModeChange [

	self uninstallShortcuts.
	self installShortcuts
]

{ #category : #accessing }
ToInfiniteElement >> preserveSelectionOnFocused [

	^ preserveSelectionOnFocused
]

{ #category : #accessing }
ToInfiniteElement >> preserveSelectionOnFocused: aBoolean [

	preserveSelectionOnFocused := aBoolean
]

{ #category : #initialization }
ToInfiniteElement >> preserveSelectionOnFocusedByDefault [

	^ true
]

{ #category : #accessing }
ToInfiniteElement >> primarySelection [

	^ self selection
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

{ #category : #'t - resizeable' }
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

{ #category : #'selection events' }
ToInfiniteElement >> selectAll [

	self dispatchSelectionChangedAfter: [
		self primarySelection selectAll ]
]

{ #category : #'selection events' }
ToInfiniteElement >> selectAndScrollTo: anIndex [

	self selectIndex: anIndex.
	self scrollToIndex: anIndex
]

{ #category : #'selection events' }
ToInfiniteElement >> selectIndex: anIndex [

	self dispatchSelectionChangedAfter: [
		self primarySelection selectIndex: anIndex.
		self scrollToIndex: anIndex ]
]

{ #category : #'selection events' }
ToInfiniteElement >> selectIndexes: aCollection [

	self dispatchSelectionChangedAfter: [
		self primarySelection deselectAll.
		aCollection ifNotEmpty: [
			self scrollToIndexAtTop: aCollection first ].
		self primarySelection selectIndexes: aCollection.
		self requestLayout ]
]

{ #category : #'selection events' }
ToInfiniteElement >> selectToIndex: anIndex [

	self dispatchSelectionChangedAfter: [
		self primarySelection selectToIndex: anIndex ]
]

{ #category : #accessing }
ToInfiniteElement >> selectedIndex [

	^ self selection selectedIndex
]

{ #category : #accessing }
ToInfiniteElement >> selectedIndexes [

	^ self selectionIndexes 
]

{ #category : #accessing }
ToInfiniteElement >> selection [

	^ self selectionStrategy
]

{ #category : #accessing }
ToInfiniteElement >> selectionIndexes [

	^ self selection selectedIndexes
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

{ #category : #'shortcuts installation' }
ToInfiniteElement >> uninstallShortcuts [

	shortcuts do: [ :s | self removeShortcut: s ].
	shortcuts := nil
]

{ #category : #dispatching }
ToInfiniteElement >> whenChildAttachedDo: aBlock [

	self addEventHandler: (BlEventHandler
			 on: BlInfiniteElementAttachedEvent
			 do: aBlock)
]

{ #category : #dispatching }
ToInfiniteElement >> whenChildDetachedDo: aBlock [

	self addEventHandler: (BlEventHandler
			 on: BlInfiniteElementDetachedEvent
			 do: aBlock)
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
