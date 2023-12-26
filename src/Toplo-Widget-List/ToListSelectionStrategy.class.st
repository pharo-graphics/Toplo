Class {
	#name : #ToListSelectionStrategy,
	#superclass : #Object,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'infiniteElement',
		'selectionModel',
		'mode',
		'currentIndex',
		'pivot',
		'distance'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> addAllToSelection: aCollection [

	self isMultiple ifFalse: [ self invalidOperation ].
	aCollection ifEmpty: [ ^ self ].
	selectionModel selectIndexes: aCollection.
	self markPointedPosition: aCollection first
]

{ #category : #'private - shortcuts' }
ToListSelectionStrategy >> addOrRemoveNext [

	self currentIndex = self dataSource itemCount ifTrue: [ ^ self ].
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
		ifTrue: [ infiniteElement dispatchDeselectIndex: nextIdx - aGap.
			selectionModel deselectIndex: nextIdx - aGap ]
		ifFalse: [			
			[
			infiniteElement dispatchCherryPickIndex: nextIdx.
			selectionModel select: nextIdx.
			nextIdx < self dataSource itemCount and: [
				nextIdx > 1 and: [ self includes: nextIdx + aGap ] ] ] whileTrue: [
				nextIdx := nextIdx + aGap.
				self distance: self distance - aGap ].
			].

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
ToListSelectionStrategy >> beMultipleSelectionIn: anInfiniteElement [ 

	mode := #multiple.
	anInfiniteElement onSelectionModeChange 
]

{ #category : #'mode changing' }
ToListSelectionStrategy >> beSingleSelectionIn: anInfiniteElement [ 

	self deselectAll.
	mode := #single.
	anInfiniteElement onSelectionModeChange 
]

{ #category : #'mode changing' }
ToListSelectionStrategy >> beWithoutSelectionIn: anInfiniteElement [ 

	self deselectAll.
	mode := #none.
	anInfiniteElement onSelectionModeChange 
]

{ #category : #'private - shortcuts' }
ToListSelectionStrategy >> checkPivot [

	self pivot ifNil: [
		self pivot: self currentIndex.
		self distance: 0 ]
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> cherryPickIndex: index [

	self isNone ifTrue: [ self invalidOperation ].
	self isMultiple ifFalse: [ self invalidOperation ].
	infiniteElement dispatchCherryPickIndex: index.
	(self includes: index)
		ifTrue: [ selectionModel deselectIndex: index ]
		ifFalse: [ selectionModel select: index ].
	self markPointedPosition: index
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
ToListSelectionStrategy >> dataSource [ 

	^ infiniteElement dataSource
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> deselect: index [

	selectionModel deselectIndex: index.
	self markPointedPosition: index
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> deselectAll [

	self isMultiple ifFalse: [ self invalidOperation ].
	infiniteElement dispatchDeselectAll.
	selectionModel deselectAll.
	self markPointedPosition: 0.

]

{ #category : #'selection managing' }
ToListSelectionStrategy >> deselectIndex: index [

	self isNone ifTrue: [ self invalidOperation ].
	infiniteElement dispatchDeselectIndex: index.
	selectionModel deselectIndex: index.
	self markPointedPosition: index
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
			self dataSource data ifEmpty: [ ^ false ].
			self markPointedPosition: 1 ]
		ifFalse: [
			self currentIndex < self dataSource data size ifFalse: [
				self markPointedPosition: 1.
				^ true ].
			self markPointedPosition: self currentIndex + 1 ].
	^ true
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> goTowardPrevious [

	self currentIndex isZero
		ifTrue: [
			self dataSource data ifEmpty: [ ^ false ].
			self markPointedPosition: self dataSource itemCount ]
		ifFalse: [
			self currentIndex > 1 ifFalse: [
				self markPointedPosition: self dataSource itemCount.
				^ true ].
			self markPointedPosition: self currentIndex - 1 ].
	^ true
]

{ #category : #'selection accessing' }
ToListSelectionStrategy >> includes: index [

	^ selectionModel includes: index
]

{ #category : #initialization }
ToListSelectionStrategy >> initialize [

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

	| selectedAfter |

	infiniteElement
		dispatchMoveSelectedIndexesFrom: aStartPosition - anItemCount + 1
		itemCount: anItemCount.
	selectedAfter := self selectedIndexes select: [ :idx |idx >= (aStartPosition - anItemCount + 1)].
	selectedAfter do: [ :idx | selectionModel deselectIndex: idx. ].
	selectedAfter reverseDo: [ :idx | selectionModel select: idx + anItemCount].
	self markPointedPosition: currentIndex + anItemCount
]

{ #category : #'data source change' }
ToListSelectionStrategy >> offsetPositionForRemove: aStartPosition itemCount: anItemCount [

	| idxs removedIdx afterIdx |
	idxs := self selectedIndexes.
	infiniteElement
		dispatchRemoveSelectedIndexesFrom: aStartPosition
		itemCount: anItemCount.
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

{ #category : #accessing }
ToListSelectionStrategy >> onInstalledIn: anInfiniteElement [

	infiniteElement := anInfiniteElement
]

{ #category : #accessing }
ToListSelectionStrategy >> onUninstalledIn: anInfiniteElement [

	infiniteElement := nil
]

{ #category : #'private - accessing' }
ToListSelectionStrategy >> pivot [

	^ pivot
]

{ #category : #'private - accessing' }
ToListSelectionStrategy >> pivot: anIndex [

	pivot := anIndex
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> select: index [

	selectionModel select: index.
	self markPointedPosition: index
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> select: aFirstIndex to: aLastIndex [

	self isMultiple ifFalse: [ self invalidOperation ].
	selectionModel select: aFirstIndex to: aLastIndex
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> selectAll [
	
	self dataSource itemCount > 0 ifFalse: [ ^ self ].
	infiniteElement dispatchSelectAll.
	self select: 1 to: self dataSource itemCount
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> selectIndex: index [

	self isNone ifTrue: [ self invalidOperation  ].
	infiniteElement dispatchSelectIndex: index.
	selectionModel select: index.
	self markPointedPosition: index
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> selectIndexes: indexes [

	self isMultiple ifFalse: [ self invalidOperation ].
	infiniteElement dispatchSelectIndexes: indexes.
	self addAllToSelection: indexes
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> selectNext [

	self goTowardNext ifTrue: [ self selectOnlyIndex: self currentIndex ]
]

{ #category : #shortcuts }
ToListSelectionStrategy >> selectNextIn: anElement event: aShortcutEvent [

	aShortcutEvent modifiers isShift
		ifTrue: [ self addOrRemoveNext ]
		ifFalse: [ self selectNext ].
	self isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #'selection managing' }
ToListSelectionStrategy >> selectOnlyIndex: index [

	self isNone ifTrue: [ self invalidOperation  ].
	infiniteElement dispatchSelectOnlyIndex: index.
	selectionModel selectIndex: index.
	self markPointedPosition: index
]

{ #category : #'private - selection managing' }
ToListSelectionStrategy >> selectPrevious [

	self goTowardPrevious ifTrue: [
		self selectOnlyIndex: self currentIndex ]
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
	infiniteElement dispatchSelectFrom: curr toIndex: index.
	self markPointedPosition: index.
	self pivot: curr.
	self distance: index - curr.
	curr < index
		ifTrue: [ self select: curr to: index ]
		ifFalse: [ self select: index to: curr ]
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
				              aList dispatchSelectionChangedAfter: [
						              self selectNextIn: aList event: aShortcutEvent ] ]).
		             (BlShortcutWithAction new
			              combination: BlKeyCombination builder arrowUp build;
			              action: [ :aShortcutEvent :aShortcut |
				              aList dispatchSelectionChangedAfter: [
						              self selectPreviousIn: aList event: aShortcutEvent ] ]) }.
	self isMultiple ifTrue: [
		shortcuts := shortcuts , {
			             (BlShortcutWithAction new
				              combination: BlKeyCombination primaryA;
				              action: [ :aShortcutEvent :aShortcut |
					              aList dispatchSelectionChangedAfter: [
							              self selectAll ] ]).
			             (BlShortcutWithAction new
				              combination: BlKeyCombination shiftArrowDown;
				              action: [ :aShortcutEvent :aShortcut |
					              aList dispatchSelectionChangedAfter: [
							              self selectNextIn: aList event: aShortcutEvent ] ]).
			             (BlShortcutWithAction new
				              combination: BlKeyCombination shiftArrowUp;
				              action: [ :aShortcutEvent :aShortcut |
					              aList dispatchSelectionChangedAfter: [
							              self
								              selectPreviousIn: aList
								              event: aShortcutEvent ] ]) } ].
	^ shortcuts
]

{ #category : #accessing }
ToListSelectionStrategy >> size [ 

	^ self selectedIndexes size
]
