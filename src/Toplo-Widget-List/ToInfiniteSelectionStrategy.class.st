Class {
	#name : #ToInfiniteSelectionStrategy,
	#superclass : #ToListSelectionStrategyDep,
	#instVars : [
		'infiniteElement',
		'mode',
		'currentIndex',
		'pivot',
		'distance',
		'installedShortcuts',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Strategy'
}

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
		ifTrue: [
			| idx |
			idx := nextIdx - aGap.
			self dispatchEvent: (ToListSelectionActionEvent new
					 action: (self
							  intervalSelectionActionWith: (idx to: idx)
							  forOperation: #deselection);
					 yourself).
			selectionModel deselectIndex: idx ]
		ifFalse: [
			[
			self dispatchEvent: (ToListSelectionActionEvent new
					 action: (self
							  intervalSelectionActionWith: (nextIdx to: nextIdx)
							  forOperation: #selection);
					 yourself).
			selectionModel selectIndex: nextIdx.
			nextIdx < self dataSource itemCount and: [
				nextIdx > 1 and: [ self includes: nextIdx + aGap ] ] ] whileTrue: [
				nextIdx := nextIdx + aGap.
				self distance: self distance - aGap ] ].

	self currentIndex: nextIdx
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
	infiniteElement selectionStrategy: self
]

{ #category : #'mode changing' }
ToInfiniteSelectionStrategy >> beSingleSelection [

	self doDeselectAll.
	mode := #single.
	infiniteElement selectionStrategy: self
]

{ #category : #'mode changing' }
ToInfiniteSelectionStrategy >> beWithoutSelection [

	self doDeselectAll.
	mode := #none.
	infiniteElement selectionStrategy: self
]

{ #category : #'private - shortcuts' }
ToInfiniteSelectionStrategy >> checkPivot [

	self pivot ifNil: [
		self pivot: self currentIndex.
		self distance: 0 ]
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> cherryPickIndex: index [

	self dispatchSelectionChangedAfter: [
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
				   self dispatchSelectionChangedAfter: [
						   self selectNextIn: infiniteElement event: aShortcutEvent ] ]).
		  (BlShortcutWithAction new
			   combination: BlKeyCombination builder arrowUp build;
			   action: [ :aShortcutEvent :aShortcut |
				   self dispatchSelectionChangedAfter: [
						   self selectPreviousIn: infiniteElement event: aShortcutEvent ] ]) }
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> deselectAll [

	self dispatchSelectionChangedAfter: [
		self doDeselectAll ]
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> deselectIndex: index [

	self dispatchSelectionChangedAfter: [
		self doDeselectIndex: index ]
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> deselectIndexes: indexes [

	self dispatchSelectionChangedAfter: [
		self doDeselectAllIndexes: indexes ]
]

{ #category : #'selection event dispatching' }
ToInfiniteSelectionStrategy >> dispatchSelectionChangedAfter: aBlock [

	| prevIndexes currentIndexes event |
	super dispatchSelectionChangedAfter: aBlock.
	prevIndexes := self selectedIndexes.

	aBlock value.

	currentIndexes := self selectedIndexes.
	prevIndexes = currentIndexes ifTrue: [ ^ self ].
	event := ToListSelectionChangedEvent new
		         previousIndexes: prevIndexes;
		         currentIndexes: currentIndexes;
		         yourself.

	self dispatchEvent: event
]

{ #category : #'selection event dispatching' }
ToInfiniteSelectionStrategy >> dispatchSelectionDirtyAfter: aBlock [

	super dispatchSelectionDirtyAfter: aBlock.
	aBlock value.
	self isNone ifTrue: [ ^ self ].
	self dispatchEvent: ToListSelectionDirtyEvent new

]

{ #category : #'selection event dispatching' }
ToInfiniteSelectionStrategy >> dispatchSelectionModeChanged [

	self dispatchEvent: ToListSelectionModeChangedEvent new
]

{ #category : #'selection event dispatching' }
ToInfiniteSelectionStrategy >> dispatchStrongSelectionChanged [

	super dispatchStrongSelectionChanged.
	self isNone ifTrue: [ ^ self ].
	self dispatchEvent: (ToListStrongSelectionEvent indexes: self selectedIndexes)
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
			self doDeselectIndex: index ]
		ifFalse: [
			self isMultiple
				ifTrue: [ self doSelectIndex: index ]
				ifFalse: [ self doSelectOnlyIndex: index ] ].
	self markPointedPosition: index
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doDeselectAll [

	self isMultiple ifFalse: [
		self doDeselectIndex: self selectedIndex.
		^ self ].
	selectionModel deselectAll.
	self dispatchEvent: (ToListSelectionActionEvent new
			 action: (self wholeSelectionActionForOperation: #deselection);
			 yourself).
	selectionModel deselectAll.
	self markPointedPosition: 0
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doDeselectAllIndexes: indexes [

	self isMultiple ifFalse: [
		indexes size > 1 ifTrue: [ self invalidOperation ] ].
	self dispatchEvent: (ToListSelectionActionEvent new
			 action: (self
					  explicitSelectionActionWith: indexes asArray
					  forOperation: #deselection);
			 yourself).
	indexes ifNotEmpty: [
		selectionModel deselectAllIndexes: indexes.
		self markPointedPosition: indexes first ].
	infiniteElement requestLayout
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doDeselectIndex: index [

	self isNone ifTrue: [ self invalidOperation ].
	self dispatchEvent: (ToListSelectionActionEvent new
			 action: (self
					  intervalSelectionActionWith: (index to: index)
					  forOperation: #deselection);
			 yourself).

	selectionModel deselectIndex: index.
	self markPointedPosition: index
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doSelectAll [

	self dataSource itemCount > 0 ifFalse: [ ^ self ].
	self dispatchEvent: (ToListSelectionActionEvent new
			 action: (self wholeSelectionActionForOperation: #selection);
			 yourself).

	selectionModel select: 0 to: self dataSource itemCount
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doSelectAllIndexes: indexes [

	self isMultiple ifFalse: [
		indexes size > 1 ifTrue: [ self invalidOperation ] ].
	self dispatchEvent: (ToListSelectionActionEvent new
			 action: (self
					  explicitSelectionActionWith: indexes asArray
					  forOperation: #selection);
			 yourself).
	indexes ifNotEmpty: [
		selectionModel selectAllIndexes: indexes.
		self markPointedPosition: indexes first ].
	infiniteElement requestLayout
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doSelectIndex: anIndex [

	self isNone ifTrue: [ self invalidOperation ].
	self dispatchEvent: (ToListSelectionActionEvent new
			 action: (self
					  intervalSelectionActionWith: (anIndex to: anIndex)
					  forOperation: #selection);
			 yourself).
	selectionModel selectIndex: anIndex.
	self markPointedPosition: anIndex
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doSelectOnlyIndex: anIndex [

	self isNone ifTrue: [ self invalidOperation ].
	self dispatchEvent: (ToListSelectionActionEvent new
			 action:
				 ((self wholeSelectionActionForOperation: #deselection) next:
						  (self
							   intervalSelectionActionWith: (anIndex to: anIndex)
							   forOperation: #selection));
			 yourself).
	selectionModel selectOnlyIndex: anIndex.
	self markPointedPosition: anIndex
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doSelectOnlyIndexes: indexes [

	self isMultiple ifFalse: [
		indexes size > 1 ifTrue: [ self invalidOperation ] ].
	(selectionModel isEmpty and: [ indexes isEmpty ]) ifTrue: [ ^ self ].
	self dispatchEvent: (ToListSelectionActionEvent new
			 action:
				 ((self wholeSelectionActionForOperation: #deselection) next:
						  (self
							   explicitSelectionActionWith: indexes asArray
							   forOperation: #selection));
			 yourself).
	selectionModel deselectAll.
	indexes ifEmpty: [ ^ self ].
	selectionModel selectAllIndexes: indexes.
	"self markPointedPosition: indexes first."
	infiniteElement requestLayout
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> doSelectToIndex: index [

	| curr |
	self isNone ifTrue: [ self invalidOperation ].
	curr := self currentIndex.
	self dispatchEvent: (ToListSelectionActionEvent new
			 action: (self
					  intervalSelectionActionWith: (curr to: index)
					  forOperation: #selection);
			 yourself).
	self markPointedPosition: index.
	self pivot: curr.
	self distance: index - curr.
	curr < index
		ifTrue: [ selectionModel select: curr - 1 to: index ]
		ifFalse: [ selectionModel select: index - 1 to: curr ]
]

{ #category : #'selection action' }
ToInfiniteSelectionStrategy >> explicitSelectionActionWith: anArray forOperation: operationKind [

	^ ToListExplicitSelectionAction new
		  indexes: anArray;
		  operation: operationKind;
		  yourself
]

{ #category : #accessing }
ToInfiniteSelectionStrategy >> first [

	^ selectionModel indices first
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
ToInfiniteSelectionStrategy >> includes: anIndex [

	^ selectionModel containsIndex: anIndex
]

{ #category : #initialization }
ToInfiniteSelectionStrategy >> initialize [

	super initialize.
	selectionModel := self newSelectionModel.
	mode := #multiple.
	currentIndex := 0
]

{ #category : #'selection and shortcuts handlers' }
ToInfiniteSelectionStrategy >> installShortcutsInInfiniteElement [

	installedShortcuts := self defaultShortcuts.
	installedShortcuts do: [ :s | infiniteElement addShortcut: s ]
]

{ #category : #'api - hooks' }
ToInfiniteSelectionStrategy >> installedHandlersInNode: aNode [

	^ aNode eventDispatcher handlers select: [ :h |
		  self nodeEventHandlerClasses anySatisfy: [ :cls | cls == h class ] ]
]

{ #category : #'selection action' }
ToInfiniteSelectionStrategy >> intervalSelectionActionWith: anInterval forOperation: operationKind [

	^ ToListIntervalSelectionAction new
		  interval: anInterval;
		  operation: operationKind;
		  yourself
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

	^ selectionModel indices last
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

{ #category : #initialization }
ToInfiniteSelectionStrategy >> newSelectionModel [

	^ BlCompositeSelection new
]

{ #category : #'selection and shortcuts handlers' }
ToInfiniteSelectionStrategy >> nodeEventHandlerClasses [

	^ {  }
]

{ #category : #'selection and shortcuts handlers' }
ToInfiniteSelectionStrategy >> nodeEventHandlers [

	^ self nodeEventHandlerClasses collect: [ :cls | cls new ]
]

{ #category : #'selection and shortcuts handlers' }
ToInfiniteSelectionStrategy >> onAddedNode: aNode [

	super onAddedNode: aNode.
	self nodeEventHandlers do: [ :handler | aNode addEventHandler: handler ]
]

{ #category : #'data source change' }
ToInfiniteSelectionStrategy >> onInfiniteDataSourceChanged [

	super onInfiniteDataSourceChanged.
	self deselectAll 
]

{ #category : #'api - hooks' }
ToInfiniteSelectionStrategy >> onInstalledIn: anInfiniteElement [

	super onInstalledIn: anInfiniteElement.
	infiniteElement := anInfiniteElement.
	self installShortcutsInInfiniteElement.
	anInfiniteElement childrenDo: [ :child | | handlersToInstall |
		handlersToInstall  := self nodeEventHandlers.
		handlersToInstall do: [ :h | child addEventHandler: h] ].

]

{ #category : #'selection and shortcuts handlers' }
ToInfiniteSelectionStrategy >> onRemovedNode: aNode [

	| installedHandlers |
	super onRemovedNode: aNode.
	installedHandlers  := self installedHandlersInNode: aNode.
	installedHandlers do: [ :h | aNode removeEventHandler: h]
]

{ #category : #'api - hooks' }
ToInfiniteSelectionStrategy >> onUninstalledIn: anInfiniteElement [

	super onUninstalledIn: anInfiniteElement.
	self uninstallShortcutsFromInfiniteElement.
	anInfiniteElement childrenDo: [ :child | | installedHandlers |
		installedHandlers  := self installedHandlersInNode: child.
		installedHandlers do: [ :h | child removeEventHandler: h] ].
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

{ #category : #initialization }
ToInfiniteSelectionStrategy >> renewSelectionModel [

	selectionModel := self newSelectionModel
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> selectAll [

	self isMultiple ifFalse: [ self invalidOperation ].
	self dispatchSelectionChangedAfter: [
		self doSelectAll ]
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> selectIndex: index [

	self dispatchSelectionChangedAfter: [
		self doSelectIndex: index ]
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> selectIndexes: indexes [

	self dispatchSelectionChangedAfter: [
		self doSelectAllIndexes: indexes ]
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

	self dispatchSelectionChangedAfter: [
		self doSelectOnlyIndex: index ]
]

{ #category : #'selection managing' }
ToInfiniteSelectionStrategy >> selectOnlyIndexes: indexes [

	self dispatchSelectionChangedAfter: [
		self doSelectOnlyIndexes: indexes ]
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

	self dispatchSelectionChangedAfter: [
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

{ #category : #accessing }
ToInfiniteSelectionStrategy >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToInfiniteSelectionStrategy >> selectionModel: aSelection [

	selectionModel := aSelection
]

{ #category : #'data source change' }
ToInfiniteSelectionStrategy >> shiftAfterAddingAt: aStartPosition itemCount: anItemCount [

	| selectedAfter |
	self dispatchEvent: (ToListSelectionActionEvent new
			 action:
				 (self shiftSelectionActionFrom: aStartPosition withGap: anItemCount);
			 yourself).
	selectedAfter := self selectedIndexes select: [ :idx |
		                 idx >= (aStartPosition - anItemCount + 1) ].
	selectedAfter do: [ :idx | selectionModel deselectIndex: idx ].
	selectedAfter reverseDo: [ :idx |
		| aToIndex |
		aToIndex := idx + anItemCount.
		selectionModel selectIndex: aToIndex ].
	self markPointedPosition: currentIndex + anItemCount
]

{ #category : #'data source change' }
ToInfiniteSelectionStrategy >> shiftAfterRemovingAt: aStartPosition itemCount: anItemCount [

	| idxs removedIdx afterIdx |
	idxs := self selectedIndexes.
	self dispatchEvent: (ToListSelectionActionEvent new
			 action:
				 (self
					  shiftSelectionActionFrom: aStartPosition
					  withGap: anItemCount negated);
			 yourself).
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
	afterIdx do: [ :i |
		| aToIndex |
		aToIndex := i - anItemCount.
		selectionModel selectIndex: aToIndex ]
]

{ #category : #'selection action' }
ToInfiniteSelectionStrategy >> shiftSelectionActionFrom: aStartPosition withGap: anInteger [

	^ ToListShiftSelectionAction new
		  fromIndex: aStartPosition;
		  gap: anInteger;
		  yourself
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

{ #category : #'selection action' }
ToInfiniteSelectionStrategy >> wholeSelectionActionForOperation: operationKind [

	^ ToListWholeDataSelectionAction new
		  operation: operationKind;
		  yourself
]
