Class {
	#name : #ToInfiniteSelectionStrategy,
	#superclass : #ToInfiniteAbstractSelectionStrategy,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'infiniteElement',
		'selectionModel',
		'mode',
		'currentIndex',
		'pivot',
		'distance',
		'installedShortcuts'
	],
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #'private - selection managing' }
ToInfiniteSelectionStrategy >> addAllToSelection: aCollection [

	self isMultiple ifFalse: [ self invalidOperation ].
	aCollection ifEmpty: [ ^ self ].
	selectionModel selectIndexes: aCollection.
	self markPointedPosition: aCollection first
]

{ #category : #'private - shortcuts' }
ToInfiniteSelectionStrategy >> addOrRemoveNext [

	self currentIndex = self dataSource itemCount ifTrue: [ ^ self ].
	self addOrRemoveWithGap: 1
]

{ #category : #'private - shortcuts' }
ToInfiniteSelectionStrategy >> addOrRemovePrevious [

	self currentIndex <= 1 ifTrue: [ ^ self ].
	self addOrRemoveWithGap: -1
]

{ #category : #'private - shortcuts' }
ToInfiniteSelectionStrategy >> addOrRemoveWithGap: aGap [

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
			infiniteElement dispatchSelectIndex: nextIdx.
			selectionModel select: nextIdx.
			nextIdx < self dataSource itemCount and: [
				nextIdx > 1 and: [ self includes: nextIdx + aGap ] ] ] whileTrue: [
				nextIdx := nextIdx + aGap.
				self distance: self distance - aGap ].
			].

	self currentIndex: nextIdx
]

{ #category : #'private - selection managing' }
ToInfiniteSelectionStrategy >> addToSelection: index [

	selectionModel select: index.
	self markPointedPosition: index
]

{ #category : #'mode api' }
ToInfiniteSelectionStrategy >> atLeastMonoSelectionDo: aBlock [

	self isNone ifTrue: [ ^ self ].
	aBlock value
]

{ #category : #'mode changing' }
ToInfiniteSelectionStrategy >> beMultipleSelection [

	mode := #multiple.
	self doDeselectAll.
	infiniteElement selection: self
]

{ #category : #'mode changing' }
ToInfiniteSelectionStrategy >> beSingleSelection [

	self doDeselectAll.
	mode := #single.
	infiniteElement selection: self
]

{ #category : #'mode changing' }
ToInfiniteSelectionStrategy >> beWithoutSelection [

	self doDeselectAll.
	mode := #none.
	infiniteElement selection: self
]

{ #category : #'private - shortcuts' }
ToInfiniteSelectionStrategy >> checkPivot [

	self pivot ifNil: [
		self pivot: self currentIndex.
		self distance: 0 ]
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> cherryPickIndex: index [

	infiniteElement dispatchSelectionChangedAfter: [
		self doCherryPickIndex: index ]
]

{ #category : #'private - accessing' }
ToInfiniteSelectionStrategy >> currentIndex [

	^ currentIndex 
]

{ #category : #'private - accessing' }
ToInfiniteSelectionStrategy >> currentIndex: anIndex [

	currentIndex := anIndex
]

{ #category : #accessing }
ToInfiniteSelectionStrategy >> dataSource [ 

	^ infiniteElement dataSource
]

{ #category : #'selection and shortcuts handlers' }
ToInfiniteSelectionStrategy >> defaultShortcuts [

	^ {
		  (BlShortcutWithAction new
			   combination: BlKeyCombination builder arrowDown build;
			   action: [ :aShortcutEvent :aShortcut |
				   infiniteElement dispatchSelectionChangedAfter: [
						   self selectNextIn: infiniteElement event: aShortcutEvent ] ]).
		  (BlShortcutWithAction new
			   combination: BlKeyCombination builder arrowUp build;
			   action: [ :aShortcutEvent :aShortcut |
				   infiniteElement dispatchSelectionChangedAfter: [
						   self selectPreviousIn: infiniteElement event: aShortcutEvent ] ]) }
]

{ #category : #'private - selection managing' }
ToInfiniteSelectionStrategy >> deselect: index [

	selectionModel deselectIndex: index.
	self markPointedPosition: index
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> deselectAll [

	infiniteElement dispatchSelectionChangedAfter: [
		self doDeselectAll ]
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> deselectIndex: index [

	infiniteElement dispatchSelectionChangedAfter: [
		self doDeselectIndex: index ]
]

{ #category : #'event management' }
ToInfiniteSelectionStrategy >> dispatchStrongSelectionChanged [

	self isNone ifTrue: [ ^ self ].
	infiniteElement dispatchStrongSelectionChanged
]

{ #category : #'private - accessing' }
ToInfiniteSelectionStrategy >> distance [
	
	^ distance
]

{ #category : #'private - accessing' }
ToInfiniteSelectionStrategy >> distance: aGap [
	
	distance := aGap
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doCherryPickIndex: index [

	self isNone ifTrue: [ self invalidOperation ].

	(self includes: index)
		ifTrue: [
			infiniteElement dispatchDeselectIndex: index.
			selectionModel deselectIndex: index ]
		ifFalse: [
			self isMultiple
				ifTrue: [ self doSelectIndex: index ]
				ifFalse: [ self doSelectOnlyIndex: index ] ].
	self markPointedPosition: index
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doDeselectAll [

	self isMultiple ifFalse: [ self invalidOperation ].
	infiniteElement dispatchDeselectAll.
	selectionModel deselectAll.
	self markPointedPosition: 0.

]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doDeselectIndex: index [

	self isNone ifTrue: [ self invalidOperation ].
	infiniteElement dispatchDeselectIndex: index.
	selectionModel deselectIndex: index.
	self markPointedPosition: index
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doSelectAll [

	self dataSource itemCount > 0 ifFalse: [ ^ self ].
	infiniteElement dispatchSelectAll.
	self select: 1 to: self dataSource itemCount
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doSelectIndex: index [

	self isNone ifTrue: [ self invalidOperation  ].
	infiniteElement dispatchSelectIndex: index.
	selectionModel select: index.
	self markPointedPosition: index.
	infiniteElement scrollToIndex: index
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doSelectIndexes: indexes [

	self isMultiple ifFalse: [ self invalidOperation ].
	self doDeselectAll.
	indexes ifNotEmpty: [
			infiniteElement scrollToIndexAtTop: indexes first ].
	infiniteElement dispatchSelectIndexes: indexes.
	self addAllToSelection: indexes.
	infiniteElement requestLayout
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doSelectOnlyIndex: index [

	self isNone ifTrue: [ self invalidOperation  ].
	infiniteElement dispatchSelectOnlyIndex: index.
	selectionModel selectIndex: index.
	self markPointedPosition: index.
	infiniteElement scrollToIndex: index 
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doSelectToIndex: index [

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

{ #category : #accessing }
ToInfiniteSelectionStrategy >> first [

	^ selectionModel first
]

{ #category : #'private - selection managing' }
ToInfiniteSelectionStrategy >> goTowardNext [ 

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
ToInfiniteSelectionStrategy >> goTowardPrevious [

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
ToInfiniteSelectionStrategy >> includes: index [

	^ selectionModel includes: index
]

{ #category : #'data source change' }
ToInfiniteSelectionStrategy >> infiniteDataSourceChanged [

	super infiniteDataSourceChanged.
	self deselectAll 
]

{ #category : #initialization }
ToInfiniteSelectionStrategy >> initialize [

	super initialize.
	selectionModel := ToInfiniteSelectionModel new.
	mode := #multiple.
	currentIndex := 0
]

{ #category : #'selection and shortcuts handlers' }
ToInfiniteSelectionStrategy >> installEventHandlersInNewNode: aNode [

	self subclassResponsibility 
]

{ #category : #'selection and shortcuts handlers' }
ToInfiniteSelectionStrategy >> installShortcutsInInfiniteElement [

	installedShortcuts := self defaultShortcuts.
	installedShortcuts do: [ :s | infiniteElement addShortcut: s ]
]

{ #category : #'private - selection managing' }
ToInfiniteSelectionStrategy >> invalidOperation [

	^ self error: 'Invalid operation'
]

{ #category : #'selection accessing' }
ToInfiniteSelectionStrategy >> isEmpty [

	^ selectionModel isEmpty
]

{ #category : #'mode testing' }
ToInfiniteSelectionStrategy >> isMultiple [

	^ mode = #multiple
]

{ #category : #'mode testing' }
ToInfiniteSelectionStrategy >> isNone [

	^ mode = #none
]

{ #category : #'selection accessing' }
ToInfiniteSelectionStrategy >> isNotEmpty [

	^ selectionModel isNotEmpty
]

{ #category : #'mode testing' }
ToInfiniteSelectionStrategy >> isSingle [

	^ self isMultiple not
]

{ #category : #accessing }
ToInfiniteSelectionStrategy >> last [

	^ selectionModel last
]

{ #category : #'private - accessing' }
ToInfiniteSelectionStrategy >> markPointedPosition: anInteger [

	" pivot and distance are used for shift-arrow-up and down management "
	self pivot: nil.
	self distance: nil.
	
	self currentIndex: anInteger.

]

{ #category : #'mode api' }
ToInfiniteSelectionStrategy >> multipleSelectionModeDo: aBlock [

	self isMultiple ifFalse: [ ^ self ].
	aBlock value
]

{ #category : #accessing }
ToInfiniteSelectionStrategy >> onInstalledIn: anInfiniteElement [

	super onInstalledIn: anInfiniteElement.
	infiniteElement := anInfiniteElement.
	self installShortcutsInInfiniteElement
]

{ #category : #'node handlers installing' }
ToInfiniteSelectionStrategy >> onNewNode: aNode [

	super onNewNode: aNode.
	self installEventHandlersInNewNode: aNode.
]

{ #category : #accessing }
ToInfiniteSelectionStrategy >> onUninstalledIn: anInfiniteElement [

	super onUninstalledIn: anInfiniteElement.
	self uninstallShortcutsFromInfiniteElement.
	infiniteElement := nil
]

{ #category : #'private - accessing' }
ToInfiniteSelectionStrategy >> pivot [

	^ pivot
]

{ #category : #'private - accessing' }
ToInfiniteSelectionStrategy >> pivot: anIndex [

	pivot := anIndex
]

{ #category : #'private - selection managing' }
ToInfiniteSelectionStrategy >> select: index [

	selectionModel select: index.
	self markPointedPosition: index
]

{ #category : #'private - selection managing' }
ToInfiniteSelectionStrategy >> select: aFirstIndex to: aLastIndex [

	self isMultiple ifFalse: [ self invalidOperation ].
	selectionModel select: aFirstIndex to: aLastIndex
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> selectAll [

	infiniteElement dispatchSelectionChangedAfter: [
		self doSelectAll ]
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> selectIndex: index [

	infiniteElement dispatchSelectionChangedAfter: [
		self doSelectIndex: index ]
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> selectIndexes: indexes [

	infiniteElement dispatchSelectionChangedAfter: [
		self doSelectIndexes: indexes ]
]

{ #category : #'private - selection managing' }
ToInfiniteSelectionStrategy >> selectNext [

	self goTowardNext ifTrue: [
		self doSelectOnlyIndex: self currentIndex ]
]

{ #category : #shortcuts }
ToInfiniteSelectionStrategy >> selectNextIn: anElement event: aShortcutEvent [

	aShortcutEvent modifiers isShift
		ifTrue: [ self addOrRemoveNext ]
		ifFalse: [ self selectNext ].
	self isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> selectOnlyIndex: index [

	infiniteElement dispatchSelectionChangedAfter: [
		self doSelectOnlyIndex: index ]
]

{ #category : #'private - selection managing' }
ToInfiniteSelectionStrategy >> selectPrevious [

	self goTowardPrevious ifTrue: [
		self doSelectOnlyIndex: self currentIndex ]
]

{ #category : #shortcuts }
ToInfiniteSelectionStrategy >> selectPreviousIn: anElement event: aShortcutEvent [

	aShortcutEvent modifiers isShift
		ifTrue: [ self addOrRemovePrevious ]
		ifFalse: [ self selectPrevious ].
	self isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex 
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> selectToIndex: index [

	infiniteElement dispatchSelectionChangedAfter: [
		self doSelectToIndex: index ]
]

{ #category : #'selection accessing' }
ToInfiniteSelectionStrategy >> selectedIndex [

	^ self selectedIndexes ifEmpty: [0] ifNotEmpty: [ :idxes | idxes first ] 
]

{ #category : #'selection accessing' }
ToInfiniteSelectionStrategy >> selectedIndexes [

	^ selectionModel indices
]

{ #category : #'data source change' }
ToInfiniteSelectionStrategy >> shiftAfterAddingAt: aStartPosition itemCount: anItemCount [

	| selectedAfter |

	infiniteElement
		dispatchShiftSelectionFrom: aStartPosition - anItemCount + 1
		itemCount: anItemCount.
	selectedAfter := self selectedIndexes select: [ :idx |idx >= (aStartPosition - anItemCount + 1)].
	selectedAfter do: [ :idx | selectionModel deselectIndex: idx. ].
	selectedAfter reverseDo: [ :idx | selectionModel select: idx + anItemCount].
	self markPointedPosition: currentIndex + anItemCount
]

{ #category : #'data source change' }
ToInfiniteSelectionStrategy >> shiftAfterRemovingAt: aStartPosition itemCount: anItemCount [

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
ToInfiniteSelectionStrategy >> size [ 

	^ self selectedIndexes size
]

{ #category : #'selection and shortcuts handlers' }
ToInfiniteSelectionStrategy >> uninstallShortcutsFromInfiniteElement [

	installedShortcuts do: [ :s | infiniteElement removeShortcut: s ].
	installedShortcuts := nil
]
