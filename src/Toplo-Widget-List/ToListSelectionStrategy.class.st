Class {
	#name : #ToListSelectionStrategy,
	#superclass : #Object,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#selectionModel',
		'#dataSource',
		'#mode => ObservableSlot',
		'#currentIndex',
		'#pivot',
		'#distance'
	],
	#category : #'Toplo-Widget-List-infinite'
}

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> addAllToSelection: aCollection [

	self isMultiple ifFalse: [ self invalidOperation ].
	aCollection ifEmpty: [ ^ self ].
	selectionModel selectIndexes: aCollection.
	self markPointedPosition: aCollection first
]

{ #category : #adding }
ToListSelectionStrategy >> addEventHandler: anEventHandler [

	selectionModel addEventHandler: anEventHandler
]

{ #category : #'private - shortcuts' }
ToListSelectionStrategy >> addOrRemoveNext [

	self currentIndex = dataSource itemCount ifTrue: [ ^ self ].
	self addOrRemoveWithGap: 1
]

{ #category : #'private - shortcuts' }
ToListSelectionStrategy >> addOrRemovePrevious [

	self currentIndex <= 1 ifTrue: [ ^ self ].
	self addOrRemoveWithGap: -1
]

{ #category : #'private - shortcuts' }
ToListSelectionStrategy >> addOrRemoveWithGap: aGap [

	| nextIdx prevDistance deselect |
	self checkPivot.

	prevDistance := self distance.
	nextIdx := self currentIndex + aGap.
	self distance: self pivot - nextIdx.

	deselect := prevDistance abs - self distance abs ~= -1.
	deselect
		ifTrue: [ selectionModel deselectIndex: nextIdx - aGap ]
		ifFalse: [
			selectionModel select: nextIdx.
			[
			nextIdx < dataSource itemCount and: [
				nextIdx > 1 and: [ self includes: nextIdx + aGap ] ] ] whileTrue: [
				nextIdx := nextIdx + aGap.
				self distance: self distance - aGap ] ].

	self currentIndex: nextIdx
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> addToSelection: index [

	selectionModel select: index.
	self markPointedPosition: index
]

{ #category : #'mode api' }
ToListSelectionStrategy >> atLeastMonoSelectionDo: aBlock [

	self isNone ifTrue: [ ^ self ].
	aBlock value
]

{ #category : #'mode changing' }
ToListSelectionStrategy >> beMultipleSelection [ 

	mode := #multiple
]

{ #category : #'mode changing' }
ToListSelectionStrategy >> beSingleSelection [ 

	self deselectAll.
	mode := #single
]

{ #category : #'mode changing' }
ToListSelectionStrategy >> beWithoutSelection [ 

	self deselectAll.
	mode := #none
]

{ #category : #'private - shortcuts' }
ToListSelectionStrategy >> checkPivot [

	self pivot ifNil: [
		self pivot: self currentIndex.
		self distance: 0 ]
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> cherryPickIndex: index [

	self isMultiple ifFalse: [ self invalidOperation ].
	(self includes: index) ifTrue: [ ^ self deselectIndex: index ].
	self addToSelection: index
]

{ #category : #'private - accessing' }
ToListSelectionStrategy >> currentIndex [

	^ currentIndex 
]

{ #category : #'private - accessing' }
ToListSelectionStrategy >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #accessing }
ToListSelectionStrategy >> dataSource: aDataSource [

	dataSource := aDataSource
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> deselectAll [

	self isMultiple ifFalse: [ self invalidOperation ].
	selectionModel deselectAll.
	self markPointedPosition: 0
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> deselectIndex: index [

	self isNone ifTrue: [ self invalidOperation ].
	selectionModel deselectIndex: index.
	self markPointedPosition: index
]

{ #category : #'event management' }
ToListSelectionStrategy >> dispatchSelectionChangedAfter: aBlock to: anInfiniteElement [

	anInfiniteElement dispatchSelectionChangedAfter: aBlock
]

{ #category : #'event management' }
ToListSelectionStrategy >> dispatchStrongSelectionChangedTo: anInfiniteElement [

	self isNone ifTrue: [ ^ self ].
	anInfiniteElement dispatchStrongSelectionChanged
]

{ #category : #'private - accessing' }
ToListSelectionStrategy >> distance [
	
	^ distance
]

{ #category : #'private - accessing' }
ToListSelectionStrategy >> distance: aGap [
	
	distance := aGap
]

{ #category : #accessing }
ToListSelectionStrategy >> first [

	^ selectionModel first
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> goTowardNext [ 

	self currentIndex isZero
		ifTrue: [
			dataSource data ifEmpty: [ ^ false ].
			self markPointedPosition: 1 ]
		ifFalse: [
			self currentIndex < dataSource data size ifFalse: [
				self markPointedPosition: 1.
				^ true ].
			self markPointedPosition: self currentIndex + 1 ].
	^ true
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> goTowardPrevious [

	self currentIndex isZero
		ifTrue: [
			dataSource data ifEmpty: [ ^ false ].
			self markPointedPosition: dataSource itemCount ]
		ifFalse: [
			self currentIndex > 1 ifFalse: [
				self markPointedPosition: dataSource itemCount.
				^ true ].
			self markPointedPosition: self currentIndex - 1 ].
	^ true
]

{ #category : #'selection accessing' }
ToListSelectionStrategy >> includes: index [

	^ selectionModel includes: index
]

{ #category : #accessing }
ToListSelectionStrategy >> infiniteElement: anInfiniteElement [

	self dataSource: anInfiniteElement dataSource
]

{ #category : #initialization }
ToListSelectionStrategy >> initialize [

	self class initializeSlots: self.
	super initialize.
	selectionModel := ToListSelectionModel new.
	mode := #multiple.
	currentIndex := 0
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> invalidOperation [

	^ self error: 'Invalid operation'
]

{ #category : #'selection accessing' }
ToListSelectionStrategy >> isEmpty [

	^ selectionModel isEmpty
]

{ #category : #'mode testing' }
ToListSelectionStrategy >> isMultiple [

	^ mode = #multiple
]

{ #category : #'mode testing' }
ToListSelectionStrategy >> isNone [

	^ mode = #none
]

{ #category : #'selection accessing' }
ToListSelectionStrategy >> isNotEmpty [

	^ selectionModel isNotEmpty
]

{ #category : #'mode testing' }
ToListSelectionStrategy >> isSingle [

	^ self isMultiple not
]

{ #category : #accessing }
ToListSelectionStrategy >> last [

	^ selectionModel last
]

{ #category : #'private - accessing' }
ToListSelectionStrategy >> markPointedPosition: anInteger [

	" pivot and distance are used for shift-arrow-up and down management "
	self pivot: nil.
	self distance: nil.
	
	self currentIndex: anInteger.

]

{ #category : #'mode api' }
ToListSelectionStrategy >> multipleSelectionModeDo: aBlock [

	self isMultiple ifFalse: [ ^ self ].
	aBlock value
]

{ #category : #'data source change' }
ToListSelectionStrategy >> offsetPositionForInsert: aStartPosition itemCount: anItemCount [

	| selected |
	selected := self selectedIndexes select: [ :idx |
		            idx >= aStartPosition ].
	selected do: [ :idx | selectionModel deselectIndex: idx ].
	selected do: [ :idx |
		self currentIndex = idx ifTrue: [
			self currentIndex: idx + anItemCount ].
		selectionModel select: idx + anItemCount ]
]

{ #category : #'data source change' }
ToListSelectionStrategy >> offsetPositionForRemove: aStartPosition itemCount: anItemCount [

	| idxs removedIdx afterIdx |
	idxs := self selectedIndexes.
	removedIdx := idxs select: [ :i |
		              i
			              between: aStartPosition
			              and: aStartPosition + anItemCount - 1 ].
	afterIdx := idxs select: [ :i |
		            i > (aStartPosition + anItemCount - 1) ].
	removedIdx do: [ :i |
		self currentIndex = i ifTrue: [ self currentIndex: 0 ].
		selectionModel deselectIndex: i ].
	afterIdx do: [ :i |
		self currentIndex = i ifTrue: [
			self currentIndex: self currentIndex - anItemCount ].
		selectionModel deselectIndex: i ].
	afterIdx do: [ :i | selectionModel select: i - anItemCount ]
]

{ #category : #'private - accessing' }
ToListSelectionStrategy >> pivot [

	^ pivot
]

{ #category : #'private - accessing' }
ToListSelectionStrategy >> pivot: anIndex [

	pivot := anIndex
]

{ #category : #adding }
ToListSelectionStrategy >> removeEventHandler: anEventHandler [

	selectionModel removeEventHandler: anEventHandler
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> select: aFirstIndex to: aLastIndex [

	self isMultiple ifFalse: [ self invalidOperation ].
	selectionModel select: aFirstIndex to: aLastIndex
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> selectAll [
	
	dataSource itemCount > 0 ifFalse: [ ^ self ].
	self select: 1 to: dataSource itemCount
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> selectIndex: index [

	self isNone ifTrue: [ self invalidOperation  ].
	selectionModel selectIndex: index.
	self markPointedPosition: index
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> selectIndexes: indexes [
	
	self isMultiple ifFalse: [ self invalidOperation ].
	self addAllToSelection: indexes
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> selectNext [

	self goTowardNext ifTrue: [ self selectIndex: self currentIndex ]
]

{ #category : #shortcuts }
ToListSelectionStrategy >> selectNextIn: anElement event: aShortcutEvent [

	aShortcutEvent modifiers isShift
		ifTrue: [ self addOrRemoveNext ]
		ifFalse: [ self selectNext ].
	self isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> selectPrevious [

	self goTowardPrevious ifTrue: [ self selectIndex: self currentIndex ]
	
]

{ #category : #shortcuts }
ToListSelectionStrategy >> selectPreviousIn: anElement event: aShortcutEvent [

	aShortcutEvent modifiers isShift
		ifTrue: [ self addOrRemovePrevious ]
		ifFalse: [ self selectPrevious ].
	self isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex 
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> selectToIndex: index [

	| curr |
	self isNone ifTrue: [ self invalidOperation ].
	curr := self currentIndex.
	curr < index ifTrue: [ 
		self markPointedPosition: index.
		self pivot: curr.
		self distance: index - curr.
		^ self select: curr to: index ].
	curr >= index ifFalse: [ ^ self ].
	self markPointedPosition: index.
	self pivot: curr.
	self distance: index - curr.
	^ self select: index to: curr
]

{ #category : #'selection accessing' }
ToListSelectionStrategy >> selectedIndex [

	^ self selectedIndexes ifEmpty: [0] ifNotEmpty: [ :idxes | idxes first ] 
]

{ #category : #'selection accessing' }
ToListSelectionStrategy >> selectedIndexes [

	^ selectionModel indices
]

{ #category : #shortcuts }
ToListSelectionStrategy >> shortcutsIn: aList [

	| shortcuts |
	shortcuts := {
		             (BlShortcutWithAction new
			              combination: BlKeyCombination builder arrowDown build;
			              action: [ :aShortcutEvent :aShortcut | 
				              aList primarySelection
					              dispatchSelectionChangedAfter: [
						              self selectNextIn: aList event: aShortcutEvent ]
					              to: aList ]).
		             (BlShortcutWithAction new
			              combination: BlKeyCombination builder arrowUp build;
			              action: [ :aShortcutEvent :aShortcut |
				              aList primarySelection
					              dispatchSelectionChangedAfter: [
						              self selectPreviousIn: aList event: aShortcutEvent ]
					              to: aList ]) }.
	self isMultiple ifTrue: [
		shortcuts := shortcuts , {
			             (BlShortcutWithAction new
				              combination: BlKeyCombination primaryA;
				              action: [ :aShortcutEvent :aShortcut |
					              aList primarySelection
						              dispatchSelectionChangedAfter: [ self selectAll ]
						              to: aList ]).
			             (BlShortcutWithAction new
				              combination: BlKeyCombination shiftArrowDown;
				              action: [ :aShortcutEvent :aShortcut |
					              aList primarySelection
						              dispatchSelectionChangedAfter: [
							              self selectNextIn: aList event: aShortcutEvent ]
						              to: aList ]).
			             (BlShortcutWithAction new
				              combination: BlKeyCombination shiftArrowUp;
				              action: [ :aShortcutEvent :aShortcut |
					              aList primarySelection
						              dispatchSelectionChangedAfter: [
							              self
								              selectPreviousIn: aList
								              event: aShortcutEvent ]
						              to: aList ]) } ].
	^ shortcuts
]

{ #category : #accessing }
ToListSelectionStrategy >> size [ 

	^ self selectedIndexes size
]

{ #category : #'slot change hook' }
ToListSelectionStrategy >> whenModeChangedDo: aBlock [

	"set a block to perform after that the slot has been changed, and its action performed"

	self property: #mode whenChangedDo: aBlock
]
