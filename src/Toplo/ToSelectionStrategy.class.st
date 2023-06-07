Class {
	#name : #ToSelectionStrategy,
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
	#category : #'Toplo-Core-Infinite'
}

{ #category : #'private - selection managing' }
ToSelectionStrategy >> addAllToSelection: aCollection [

	self isMultiple ifFalse: [ self invalidOperation ].
	aCollection ifEmpty: [ ^ self ].
	selectionModel selectIndexes: aCollection.
	self markPointedPosition: aCollection first
]

{ #category : #'private - shortcuts' }
ToSelectionStrategy >> addOrRemoveNext [

	self currentIndex = dataSource itemCount ifTrue: [ ^ self ].
	self addOrRemoveWithGap: 1
]

{ #category : #'private - shortcuts' }
ToSelectionStrategy >> addOrRemovePrevious [

	self currentIndex <= 1 ifTrue: [ ^ self ].
	self addOrRemoveWithGap: -1
]

{ #category : #'private - shortcuts' }
ToSelectionStrategy >> addOrRemoveWithGap: aGap [

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
ToSelectionStrategy >> addToSelection: index [

	selectionModel select: index.
	self markPointedPosition: index
]

{ #category : #'mode api' }
ToSelectionStrategy >> atLeastMonoSelectionDo: aBlock [

	self isNone ifTrue: [ ^ self ].
	aBlock value
]

{ #category : #'mode changing' }
ToSelectionStrategy >> beMultipleSelection [ 

	mode := #multiple
]

{ #category : #'mode changing' }
ToSelectionStrategy >> beSingleSelection [ 

	self deselectAll.
	mode := #single
]

{ #category : #'mode changing' }
ToSelectionStrategy >> beWithoutSelection [ 

	self deselectAll.
	mode := #none
]

{ #category : #'private - shortcuts' }
ToSelectionStrategy >> checkPivot [

	self pivot ifNil: [
		self pivot: self currentIndex.
		self distance: 0 ]
]

{ #category : #'selection managing' }
ToSelectionStrategy >> cherryPickIndex: index [

	self isMultiple ifFalse: [ self invalidOperation ].
	(self includes: index) ifTrue: [ ^ self deselectIndex: index ].
	self addToSelection: index
]

{ #category : #'private - accessing' }
ToSelectionStrategy >> currentIndex [

	^ currentIndex 
]

{ #category : #'private - accessing' }
ToSelectionStrategy >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #accessing }
ToSelectionStrategy >> dataSource: aDataSource [

	dataSource := aDataSource
]

{ #category : #'selection managing' }
ToSelectionStrategy >> deselectAll [

	self isMultiple ifFalse: [ self invalidOperation ].
	selectionModel deselectAll.
	self markPointedPosition: 0
]

{ #category : #'selection managing' }
ToSelectionStrategy >> deselectIndex: index [

	self isNone ifTrue: [ self invalidOperation ].
	selectionModel deselectIndex: index
]

{ #category : #'event management' }
ToSelectionStrategy >> dispatchSelectionChangedAfter: aBlock to: anInfiniteElement [

	anInfiniteElement dispatchSelectionChangedAfter: aBlock
]

{ #category : #'event management' }
ToSelectionStrategy >> dispatchStrongSelectionChangedTo: anInfiniteElement [

	self isNone ifTrue: [ ^ self ].
	anInfiniteElement dispatchStrongSelectionChanged
]

{ #category : #'private - accessing' }
ToSelectionStrategy >> distance [
	
	^ distance
]

{ #category : #'private - accessing' }
ToSelectionStrategy >> distance: aGap [
	
	distance := aGap
]

{ #category : #accessing }
ToSelectionStrategy >> first [

	^ selectionModel first
]

{ #category : #'private - selection managing' }
ToSelectionStrategy >> goTowardNext [ 

	self currentIndex isZero
		ifTrue: [
			dataSource list ifEmpty: [ ^ false ].
			self markPointedPosition: 1 ]
		ifFalse: [
			self currentIndex < dataSource list size ifFalse: [
				self markPointedPosition: 1.
				^ true ].
			self markPointedPosition: self currentIndex + 1 ].
	^ true
]

{ #category : #'private - selection managing' }
ToSelectionStrategy >> goTowardPrevious [

	self currentIndex isZero
		ifTrue: [
			dataSource list ifEmpty: [ ^ false ].
			self markPointedPosition: dataSource itemCount ]
		ifFalse: [
			self currentIndex > 1 ifFalse: [
				self markPointedPosition: dataSource itemCount.
				^ true ].
			self markPointedPosition: self currentIndex - 1 ].
	^ true
]

{ #category : #'selection accessing' }
ToSelectionStrategy >> includes: index [

	^ selectionModel includes: index
]

{ #category : #accessing }
ToSelectionStrategy >> infiniteElement: anInfiniteElement [

	self dataSource: anInfiniteElement dataSource
]

{ #category : #initialization }
ToSelectionStrategy >> initialize [

	self class initializeSlots: self.
	super initialize.
	selectionModel := ToSelectionModel new.
	mode := #multiple.
	currentIndex := 0
]

{ #category : #'private - selection managing' }
ToSelectionStrategy >> invalidOperation [

	^ self error: 'Invalid operation'
]

{ #category : #'selection accessing' }
ToSelectionStrategy >> isEmpty [

	^ selectionModel isEmpty
]

{ #category : #'mode testing' }
ToSelectionStrategy >> isMultiple [

	^ mode = #multiple
]

{ #category : #'mode testing' }
ToSelectionStrategy >> isNone [

	^ mode = #none
]

{ #category : #'selection accessing' }
ToSelectionStrategy >> isNotEmpty [

	^ selectionModel isNotEmpty
]

{ #category : #'mode testing' }
ToSelectionStrategy >> isSingle [

	^ self isMultiple not
]

{ #category : #accessing }
ToSelectionStrategy >> last [

	^ selectionModel last
]

{ #category : #'private - accessing' }
ToSelectionStrategy >> markPointedPosition: anInteger [

	" pivot and distance are used for shift-arrow-up and down management "
	self pivot: nil.
	self distance: nil.
	
	self currentIndex: anInteger.

]

{ #category : #'mode api' }
ToSelectionStrategy >> multipleSelectionModeDo: aBlock [

	self isMultiple ifFalse: [ ^ self ].
	aBlock value
]

{ #category : #'data source change' }
ToSelectionStrategy >> offsetPositionForInsert: aStartPosition itemCount: anItemCount [

	| selected |
	selected := self selectedIndexes select: [ :idx |
		            idx >= aStartPosition ].
	selected do: [ :idx | self deselectIndex: idx ].
	selected do: [ :idx |
		self currentIndex = idx ifTrue: [
			self currentIndex: idx + anItemCount ].
		selectionModel select: idx + anItemCount ]
]

{ #category : #'data source change' }
ToSelectionStrategy >> offsetPositionForRemove: aStartPosition itemCount: anItemCount [

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
ToSelectionStrategy >> pivot [

	^ pivot
]

{ #category : #'private - accessing' }
ToSelectionStrategy >> pivot: anIndex [

	pivot := anIndex
]

{ #category : #'private - selection managing' }
ToSelectionStrategy >> select: aFirstIndex to: aLastIndex [

	(self isMultiple not and: [ aLastIndex > aFirstIndex ]) ifTrue: [ self invalidOperation ].
	selectionModel select: aFirstIndex to: aLastIndex.
	aFirstIndex = aLastIndex ifTrue: [ self markPointedPosition: aFirstIndex ]
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectAll [
	
	dataSource itemCount > 0 ifFalse: [ ^ self ].
	self select: 1 to: dataSource itemCount
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectIndex: index [

	self isNone ifTrue: [ self invalidOperation  ].
	selectionModel selectIndex: index.
	self markPointedPosition: index
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectIndexes: indexes [
	
	self isMultiple ifFalse: [ self invalidOperation ].
	self addAllToSelection: indexes
]

{ #category : #'private - selection managing' }
ToSelectionStrategy >> selectNext [

	self goTowardNext ifTrue: [ self selectIndex: self currentIndex ]
]

{ #category : #shortcuts }
ToSelectionStrategy >> selectNextIn: anElement event: aShortcutEvent [

	aShortcutEvent modifiers isShift
		ifTrue: [ self addOrRemoveNext ]
		ifFalse: [ self selectNext ].
	self isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #'private - selection managing' }
ToSelectionStrategy >> selectPrevious [

	self goTowardPrevious ifTrue: [ self selectIndex: self currentIndex ]
	
]

{ #category : #shortcuts }
ToSelectionStrategy >> selectPreviousIn: anElement event: aShortcutEvent [

	aShortcutEvent modifiers isShift
		ifTrue: [ self addOrRemovePrevious ]
		ifFalse: [ self selectPrevious ].
	self isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex 
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectToIndex: index [

	| indexes |
	self isNone ifTrue: [ self invalidOperation ].
	indexes := self selectedIndexes.
	indexes ifEmpty: [ ^ selectionModel selectIndex: index ].
	indexes first < index ifTrue: [
		self deselectAll.
		^ self select: indexes first to: index ].
	indexes last >= index ifFalse: [ ^ self ].
	self deselectAll.
	^ self select: index to: indexes last
]

{ #category : #'selection accessing' }
ToSelectionStrategy >> selectedIndex [

	^ self selectedIndexes ifEmpty: [0] ifNotEmpty: [ :idxes | idxes first ] 
]

{ #category : #'selection accessing' }
ToSelectionStrategy >> selectedIndexes [

	^ selectionModel indices
]

{ #category : #shortcuts }
ToSelectionStrategy >> shortcutsIn: aList [

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
ToSelectionStrategy >> size [ 

	^ self selectedIndexes size
]

{ #category : #'event management' }
ToSelectionStrategy >> unsubscribe: anObject [

	selectionModel unsubscribe: anObject
]

{ #category : #'event management' }
ToSelectionStrategy >> whenAnnouncement: anAnnouncementClass send: aSelector to: anObject [

	selectionModel whenAnnouncement: anAnnouncementClass send: aSelector to: anObject
]

{ #category : #'slot change hook' }
ToSelectionStrategy >> whenModeChangedDo: aBlock [

	"set a block to perform after that the slot has been changed, and its action performed"

	self property: #mode whenChangedDo: aBlock
]
