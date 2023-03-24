Class {
	#name : #ToSelectionStrategy,
	#superclass : #Object,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#selectionModel',
		'#dataSource',
		'#mode => ObservableSlot',
		'#prevDir',
		'#currentIndex'
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
	self currentIndex = dataSource itemCount ifTrue: [ ^ self ].
	next := prevDir = #next
		        ifTrue: [ self currentIndex + 1 ]
		        ifFalse: [ self currentIndex ].
	prevDir := #next.

	(self includes: next)
		ifTrue: [
			self selectedIndexes size > 1
				ifTrue: [ self deselectIndex: next ]
				ifFalse: [
					next := next + 1.
					self addToSelection: next ] ]
		ifFalse: [ self addToSelection: next ].
	self currentIndex:  next
]

{ #category : #'selection managing' }
ToSelectionStrategy >> addOrRemovePrevious [

	| next |
	self currentIndex = 1 ifTrue: [ ^ self ].
	next := prevDir = #previous
		        ifTrue: [ self currentIndex - 1 max: 1]
		        ifFalse: [ self currentIndex ].
	prevDir := #previous.

	(self includes: next)
		ifTrue: [
			self selectedIndexes size > 1
				ifTrue: [ self deselectIndex: next ]
				ifFalse: [
					next := next - 1.
					self addToSelection: next ] ]
		ifFalse: [ self addToSelection: next ].
	self currentIndex: next
]

{ #category : #'selection managing' }
ToSelectionStrategy >> addToSelection: index [

	self select: index to: index.
	self currentIndex: index
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

	self deselectAll.
	mode := #none
]

{ #category : #'selection managing' }
ToSelectionStrategy >> cherryPickIndex: index [

	(self includes: index) ifTrue: [ ^ self deselectIndex: index ].
	self select: index to: index
]

{ #category : #'selection managing' }
ToSelectionStrategy >> clearAndSelectIndex: index [

	self deselectAll.
	self selectIndex: index.
]

{ #category : #accessing }
ToSelectionStrategy >> currentIndex [

	^ currentIndex ifNil: [ currentIndex := 1 ]
]

{ #category : #accessing }
ToSelectionStrategy >> currentIndex: anInteger [

	currentIndex := anInteger 
]

{ #category : #accessing }
ToSelectionStrategy >> dataSource: aDataSource [

	dataSource := aDataSource
]

{ #category : #'selection managing' }
ToSelectionStrategy >> deselectAll [

	selectionModel deselectAll
]

{ #category : #'selection managing' }
ToSelectionStrategy >> deselectIndex: index [

	selectionModel deselectIndex: index.
	self currentIndex: index
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
ToSelectionStrategy >> isNotEmpty [

	^ selectionModel isNotEmpty
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
	selected do: [ :idx | self deselectIndex: idx ].
	selected do: [ :idx | self addToSelection: idx + anItemCount ].
]

{ #category : #'data source change' }
ToSelectionStrategy >> offsetPositionForRemove: aStartPosition itemCount: anItemCount [

	aStartPosition to: aStartPosition + anItemCount - 1 do: [ :idx |
		self deselectIndex: idx ]
]

{ #category : #'selection managing' }
ToSelectionStrategy >> select: aFirstIndex to: aLastIndex [

	(self isMultiple not and: [ aLastIndex > aFirstIndex ]) ifTrue: [ self invalidOperation ].
	selectionModel select: aFirstIndex to: aLastIndex.
	aFirstIndex = aLastIndex ifTrue: [ self currentIndex: aFirstIndex ]
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectAll [
	
	dataSource itemCount > 0 ifFalse: [ ^ self ].
	self select: 1 to: dataSource itemCount
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectIndex: index [

	selectionModel selectIndex: index.
	self currentIndex: index
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectIndexes: indexes [
	
	self isMultiple ifFalse: [ self error: 'Invalid operation' ].
	indexes do: [ :idx | self addToSelection: idx ]
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectLast [

	dataSource itemCount > 0 ifFalse: [ ^ self ].
	self selectIndex: dataSource itemCount

]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectNext [

	self currentIndex < dataSource list size ifFalse: [ ^ self ].
	self currentIndex: self currentIndex + 1.
	self selectIndex: self currentIndex
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectNextIn: anElement event: aShortcutEvent [

	aShortcutEvent modifiers isShift
		ifTrue: [ self addOrRemoveNext ]
		ifFalse: [ self selectNext ].
	self isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectPrevious [

	self currentIndex > 1 ifFalse: [ ^ self ].
	self currentIndex: self currentIndex - 1.
	self selectIndex: self currentIndex
	
]

{ #category : #'selection managing' }
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
	indexes := self selectedIndexes.
	indexes ifEmpty: [ ^ selectionModel selectIndex: index ].
	indexes first < index ifTrue: [ 
		self deselectAll.
		^ self select: indexes first to: index ].
	indexes last >= index ifTrue: [ 
		self deselectAll.
		^ self select: index to: indexes last ]
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
