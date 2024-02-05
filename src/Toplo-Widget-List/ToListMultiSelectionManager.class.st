Class {
	#name : #ToListMultiSelectionManager,
	#superclass : #ToListSelectionManager,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #initialization }
ToListMultiSelectionManager >> defaultSelectionMode [

	^ ToListMultiSelectionMode new
]

{ #category : #accessing }
ToListMultiSelectionManager >> nodeEventHandlerClasses [ 

	^ { ToListNodeMultiSelectionClickEventHandler }
]

{ #category : #'event handling' }
ToListMultiSelectionManager >> onClickOnNode: aNode event: anEvent [

	anEvent modifiers isShift ifTrue: [
		^ self selecter selectToIndex: aNode holder position ].
	anEvent modifiers isPrimaryModifier ifTrue: [
		^ self selecter cherryPickIndex: aNode holder position ].
	self selecter selectOnlyIndex: aNode holder position
]

{ #category : #shortcuts }
ToListMultiSelectionManager >> selectOrDeselectNextIn: anElement event: aShortcutEvent [

	self selecter selectOrDeselectNext.
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self selectionModel currentIndex
]

{ #category : #shortcuts }
ToListMultiSelectionManager >> selectOrDeselectPreviousIn: anElement event: aShortcutEvent [

	self selecter selectOrDeselectPrevious.
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self selectionModel currentIndex
]

{ #category : #shortcuts }
ToListMultiSelectionManager >> shortcutsIn: anElement [

	^ (super shortcutsIn: anElement) , {
		  (BlShortcutWithAction new
			   combination: BlKeyCombination primaryA;
			   action: [ :aShortcutEvent :aShortcut | self selecter selectAll ]).
		  (BlShortcutWithAction new
			   combination: BlKeyCombination builder shift arrowDown build;
			   action: [ :aShortcutEvent :aShortcut |
				   self selectOrDeselectNextIn: anElement event: aShortcutEvent ]).
		  (BlShortcutWithAction new
			   combination: BlKeyCombination builder shift arrowUp build;
			   action: [ :aShortcutEvent :aShortcut |
				   self
					   selectOrDeselectPreviousIn: anElement
					   event: aShortcutEvent ]) }
]
