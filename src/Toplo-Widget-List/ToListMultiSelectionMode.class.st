Class {
	#name : #ToListMultiSelectionMode,
	#superclass : #ToListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToListMultiSelectionMode >> nodeEventHandlerClasses [ 

	^ { ToListNodeMultiSelectionClickEventHandler }
]

{ #category : #'event handling' }
ToListMultiSelectionMode >> onClickOnNode: aNode event: anEvent [

	anEvent sourceEvent modifiers isShift ifTrue: [
		self selecter selectToIndex: aNode holder position.
		^ self ].
	anEvent sourceEvent modifiers isPrimaryModifier ifTrue: [
		| index target |
		index := aNode holder position.
		target := anEvent listElement.
		(target selectionModel containsIndex: index)
			ifTrue: [ self selecter deselectIndex: index ]
			ifFalse: [ self selecter selectIndex: index ].
		^ self ].
	self selecter
		selectOnlyIndex: aNode holder position
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
				   self selecter selectOrDeselectNextIn: anElement event: aShortcutEvent ]).
		  (BlShortcutWithAction new
			   combination: BlKeyCombination builder shift arrowUp build;
			   action: [ :aShortcutEvent :aShortcut |
				   self selecter
					   selectOrDeselectPreviousIn: anElement
					   event: aShortcutEvent ]) }
]
