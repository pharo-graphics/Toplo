Class {
	#name : #ToListMultiSelectionMode,
	#superclass : #ToListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListMultiSelectionMode >> allowNodeSelectionOnMouseDown [

	( self selectedIndexesCount > 1 )
		ifTrue: [ self preserveSelectionOnFocused ifTrue: [ ^ false ] ].
	^ super allowNodeSelectionOnMouseDown
]

{ #category : #'instance creation' }
ToListMultiSelectionMode >> newSelecterIn: anElement [

	^ ToMultiSelectionModelSelecter new 
]

{ #category : #accessing }
ToListMultiSelectionMode >> nodeEventHandlerClasses [ 

	^ { ToListNodeMultiSelectionClickEventHandler }
]

{ #category : #'event handling' }
ToListMultiSelectionMode >> onClickEvent: anEvent onNode: aNode [

	super onClickEvent: anEvent onNode: aNode.
	anEvent modifiers isShift ifTrue: [
		| curr |
		curr := self selecter currentIndex.
		self selecter selectIndex: curr to: aNode holder position.
		^ self ].
	anEvent modifiers isPrimaryModifier ifTrue: [
		| index target |
		index := aNode holder position.
		target := aNode holder listElement.
		(target selectionModel containsIndex: index)
			ifTrue: [ self selecter deselectIndex: index ]
			ifFalse: [ self selecter selectIndex: index ].
		^ self ].
	self selecter selectOnlyIndex: aNode holder position
]

{ #category : #shortcuts }
ToListMultiSelectionMode >> shortcutsIn: anElement [

	^ (super shortcutsIn: anElement) , {
		  (BlShortcutWithAction new
			   combination: BlKeyCombination primaryA;
			   action: [ :aShortcutEvent :aShortcut | self selecter selectAll ]).
		  (BlShortcutWithAction new
			   combination: BlKeyCombination builder shift arrowDown build;
			   action: [ :aShortcutEvent :aShortcut |
				   | idx |
				   idx := self selecter nextDeselectedIndex.
				   self selecter selectIndex: idx.
				   self selecter scrollToIndex: idx ]).
		  (BlShortcutWithAction new
			   combination: BlKeyCombination builder shift arrowUp build;
			   action: [ :aShortcutEvent :aShortcut |
				   | idx |
				   idx := self selecter previousDeselectedIndex.
				   self selecter selectIndex: idx.
				   self selecter scrollToIndex: idx ]) }
]
