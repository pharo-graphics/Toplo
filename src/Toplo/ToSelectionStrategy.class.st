Class {
	#name : #ToSelectionStrategy,
	#superclass : #Object,
	#instVars : [
		'selectionModel',
		'dataSource',
		'mode'
	],
	#category : #'Toplo-Core-Infinite'
}

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

	selectionModel deselectOne: index

]

{ #category : #accessing }
ToSelectionStrategy >> dataSource: aDataSource [

	dataSource := aDataSource
]

{ #category : #initialization }
ToSelectionStrategy >> initialize [

	super initialize.
	selectionModel := ToSelectionModel new.
	mode := #multiple
]

{ #category : #'selection accessing' }
ToSelectionStrategy >> isEmpty [

	^ selectionModel isEmpty
]

{ #category : #'mode testing' }
ToSelectionStrategy >> isMultiple [

	^ mode = #multiple
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
ToSelectionStrategy >> selectAll [
	
	dataSource itemCount > 0 ifFalse: [ ^ self ].
	self selectInterval: (1 to: dataSource itemCount)
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectFirst [

	dataSource itemCount > 0 ifFalse: [ ^ self ].
	self selectIndex: 1

]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectIndex: index [

	selectionModel selectOne: index
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectInterval: anInterval [

	selectionModel select: anInterval first to: anInterval last
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectLast [

	dataSource itemCount > 0 ifFalse: [ ^ self ].
	self selectIndex: dataSource itemCount

]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectNext [

	| indexes |
	indexes := self selectedIndexes.
	indexes isEmpty ifTrue: [ ^ self selectIndex: 1 ].
	indexes last = dataSource itemCount ifTrue: [ ^ self ].
	^ self selectIndex: indexes last + 1
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectNextIn: anElement event: aShortcutEvent [

	| idx |
	self selectNext.
	self isEmpty ifTrue: [ ^ self ].
	idx := self selectedIndexes last.
	anElement scrollToIndex: idx
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectPrevious [

	| indexes |
	indexes := self selectedIndexes.
	indexes isEmpty ifTrue: [ ^ self selectIndex: 1 ].
	indexes first = 1 ifTrue: [ ^ self ].
	^ self selectIndex: indexes first - 1
]

{ #category : #'selection managing' }
ToSelectionStrategy >> selectPreviousIn: anElement event: aShortcutEvent [

	| idx |
	self selectPrevious.
	self isEmpty ifTrue: [ ^ self ].
	idx := self selectedIndexes first.
	anElement scrollToIndex: idx
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
				              aList dispatchSelectionChangedAfter: [ 
						              self selectNextIn: aList event: aShortcutEvent ] ]).
		             (BlShortcutWithAction new
			              combination: BlKeyCombination builder arrowUp build;
			              action: [ :aShortcutEvent :aShortcut | 
				              aList dispatchSelectionChangedAfter: [ 
						              self selectPreviousIn: aList event: aShortcutEvent ] ]) }.
	self isMultiple ifTrue: [ 
		shortcuts := shortcuts , { (BlShortcutWithAction new
			              combination: BlKeyCombination primaryA;
			              action: [ :aShortcutEvent :aShortcut | 
				              aList dispatchSelectionChangedAfter: [ 
						              self selectAll ] ]) } ].
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
