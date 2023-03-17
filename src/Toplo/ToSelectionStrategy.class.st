Class {
	#name : #ToSelectionStrategy,
	#superclass : #Object,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#selectionModel',
		'#dataSource',
		'#mode => ObservableSlot',
		'#lastManagedIndex',
		'#prevDir'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #'selection managing' }
ToSelectionStrategy >> addNextToSelection [

	| indexes |
	indexes := self selectedIndexes.
	indexes isEmpty ifTrue: [ ^ self selectIndex: 1 ].
	indexes last = dataSource itemCount ifTrue: [ ^ self ].
	^ self addToSelection: indexes last + 1
]

{ #category : #'selection managing' }
ToSelectionStrategy >> addOrRemoveNext [

	| next |
	lastManagedIndex = dataSource itemCount ifTrue: [ ^ self ].
	next := prevDir = #next
		        ifTrue: [ lastManagedIndex + 1 ]
		        ifFalse: [ lastManagedIndex ].
	prevDir := #next.

	(self isSelected: next)
		ifTrue: [
			self selectedIndexes size > 1
				ifTrue: [ self clearSelection: next ]
				ifFalse: [
					next := next + 1.
					self addToSelection: next ] ]
		ifFalse: [ self addToSelection: next ].
	lastManagedIndex := next
]

{ #category : #'selection managing' }
ToSelectionStrategy >> addOrRemovePrevious [

	| next |
	lastManagedIndex = 1 ifTrue: [ ^ self ].
	next := prevDir = #previous
		        ifTrue: [ lastManagedIndex - 1 ]
		        ifFalse: [ lastManagedIndex ].
	prevDir := #previous.

	(self isSelected: next)
		ifTrue: [
			self selectedIndexes size > 1
				ifTrue: [ self clearSelection: next ]
				ifFalse: [
					next := next - 1.
					self addToSelection: next ] ]
		ifFalse: [ self addToSelection: next ].
	lastManagedIndex := next
]

{ #category : #'selection managing' }
ToSelectionStrategy >> addToSelection: index [

	self selectInterval: (index to: index).
	lastManagedIndex := index
]

{ #category : #'selection managing' }
ToSelectionStrategy >> atLeastMonoSelectionDo: aBlock [

	self isNone ifTrue: [ ^ self ].
	aBlock value
]

{ #category : #'mode testing' }
ToSelectionStrategy >> beMultipleSelection [ 

	mode := #multiple
]

{ #category : #'mode testing' }
ToSelectionStrategy >> beSingleSelection [ 

	mode := #single
]

{ #category : #'mode testing' }
ToSelectionStrategy >> beWithoutSelection [ 

	self clearSelection.
	mode := #none
]

{ #category : #'selection managing' }
ToSelectionStrategy >> cherryPickIndex: index [

	(self isSelected: index) ifTrue: [ ^ self clearSelection: index ].
	self selectInterval: (index to: index)
]

{ #category : #'selection managing' }
ToSelectionStrategy >> clearAndSelectIndex: index [

	self clearSelection.
	self selectIndex: index.
]

{ #category : #'selection managing' }
ToSelectionStrategy >> clearSelection [

	selectionModel deselectAll
]

{ #category : #'selection managing' }
ToSelectionStrategy >> clearSelection: index [

	selectionModel deselectOne: index.
	lastManagedIndex := index
]

{ #category : #accessing }
ToSelectionStrategy >> dataSource: aDataSource [

	dataSource := aDataSource
]

{ #category : #'selection managing' }
ToSelectionStrategy >> deselectInterval: anInterval [

	selectionModel deselect: anInterval first to: anInterval last

]

{ #category : #'event management' }
ToSelectionStrategy >> dispatchSelectionChangedAfter: aBlock to: anInfiniteElement [

	self isNone ifTrue: [ ^ self ].
	anInfiniteElement dispatchSelectionChangedAfter: aBlock
]

{ #category : #'event management' }
ToSelectionStrategy >> dispatchStrongSelectionChangedTo: anInfiniteElement [

	self isNone ifTrue: [ ^ self ].
	anInfiniteElement dispatchStrongSelectionChanged
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
	mode := #multiple
]

{ #category : #'selection managing' }
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
ToSelectionStrategy >> isSelected: index [

	^ selectionModel includes: index
]

{ #category : #'mode testing' }
ToSelectionStrategy >> isSingle [

	^ self isMultiple not
]

{ #category : #'selection managing' }
ToSelectionStrategy >> multipleSelectionModeDo: aBlock [

	self isMultiple ifFalse: [ ^ self ].
	aBlock value
]

{ #category : #'data source change' }
ToSelectionStrategy >> offsetPositionForInsert: aStartPosition itemCount: anItemCount [

	| selected |
	selected := self selectedIndexes select: [ :idx | idx >= aStartPosition ].
	selected do: [ :idx | self clearSelection: idx ].
	selected do: [ :idx | self addToSelection: idx + anItemCount ].
]

{ #category : #'data source change' }
ToSelectionStrategy >> offsetPositionForRemove: aStartPosition itemCount: anItemCount [

	aStartPosition to: aStartPosition + anItemCount - 1 do: [ :idx |
		self clearSelection: idx ]
]

{ #category : #'selection managing' }
ToSelectionStrategy >> rawDeselect: anIndex [ 

	selectionModel rawDeselect: anIndex

]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectAll [
	
	dataSource itemCount > 0 ifFalse: [ ^ self ].
	self clearSelection.
	self selectInterval: (1 to: dataSource itemCount)
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectFirst [

	dataSource itemCount > 0 ifFalse: [ ^ self ].
	self selectIndex: 1

]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectIndex: index [

	selectionModel selectOne: index.
	lastManagedIndex := index
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectIndexes: indexes [
	
	self isMultiple ifFalse: [ self error: 'Invalid operation' ].
	indexes do: [ :idx | self addToSelection: idx ]
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectInterval: anInterval [

	(self isMultiple not and: [ anInterval size > 1 ]) ifTrue: [ self invalidOperation ].
	selectionModel select: anInterval first to: anInterval last
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectLast [

	dataSource itemCount > 0 ifFalse: [ ^ self ].
	self selectIndex: dataSource itemCount

]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectNext [

	lastManagedIndex < dataSource list size ifFalse: [ ^ self ].
	lastManagedIndex := lastManagedIndex + 1.
	self selectIndex: lastManagedIndex
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectNextIn: anElement event: aShortcutEvent [

	aShortcutEvent modifiers isShift
		ifTrue: [ self addOrRemoveNext ]
		ifFalse: [ self selectNext ].
	self isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: lastManagedIndex
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectPrevious [

	lastManagedIndex > 1 ifFalse: [ ^ self ].
	lastManagedIndex := lastManagedIndex - 1.
	self selectIndex: lastManagedIndex
	
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectPreviousIn: anElement event: aShortcutEvent [

	aShortcutEvent modifiers isShift
		ifTrue: [ self addOrRemovePrevious ]
		ifFalse: [ self selectPrevious ].
	self isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: lastManagedIndex 
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectToIndex: index [

	| indexes |
	indexes := self selectedIndexes.
	indexes ifEmpty: [ ^ selectionModel selectOne: index ].
	indexes first < index ifTrue: [ 
		self clearSelection.
		^ self selectInterval: (indexes first to: index) ].
	indexes last >= index ifTrue: [ 
		self clearSelection.
		^ self selectInterval: (index to: indexes last) ]
]

{ #category : #'selection accessing' }
ToSelectionStrategy >> selectedIndex [

	| idx |
	idx := self selectedIndexes.
	^ idx first 
]

{ #category : #'selection accessing' }
ToSelectionStrategy >> selectedIndexes [

	^ selectionModel indices
]

{ #category : #'selection accessing' }
ToSelectionStrategy >> selectedNode [

	^ dataSource list at: self selectedIndex
]

{ #category : #'selection accessing' }
ToSelectionStrategy >> selectedNodes [

	^ self selectedIndexes collect: [ :idx | dataSource list at: idx  ]
]

{ #category : #shortcuts }
ToSelectionStrategy >> shortcutsIn: aList [

	| shortcuts |
	shortcuts := {
		             (BlShortcutWithAction new
			              combination: BlKeyCombination builder arrowDown build;
			              action: [ :aShortcutEvent :aShortcut |
				              aList selectionStrategy
					              dispatchSelectionChangedAfter: [
						              self selectNextIn: aList event: aShortcutEvent ]
					              to: aList ]).
		             (BlShortcutWithAction new
			              combination: BlKeyCombination builder arrowUp build;
			              action: [ :aShortcutEvent :aShortcut |
				              aList selectionStrategy
					              dispatchSelectionChangedAfter: [
						              self selectPreviousIn: aList event: aShortcutEvent ]
					              to: aList ]) }.
	self isMultiple ifTrue: [
		shortcuts := shortcuts , {
			             (BlShortcutWithAction new
				              combination: BlKeyCombination primaryA;
				              action: [ :aShortcutEvent :aShortcut |
					              aList selectionStrategy
						              dispatchSelectionChangedAfter: [ self selectAll ]
						              to: aList ]).
			             (BlShortcutWithAction new
				              combination: BlKeyCombination shiftArrowDown;
				              action: [ :aShortcutEvent :aShortcut |
					              aList selectionStrategy
						              dispatchSelectionChangedAfter: [
							              self selectNextIn: aList event: aShortcutEvent ]
						              to: aList ]).
			             (BlShortcutWithAction new
				              combination: BlKeyCombination shiftArrowUp;
				              action: [ :aShortcutEvent :aShortcut |
					              aList selectionStrategy
						              dispatchSelectionChangedAfter: [
							              self
								              selectPreviousIn: aList
								              event: aShortcutEvent ]
						              to: aList ]) } ].
	^ shortcuts
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
