Class {
	#name : #ToListMultiSelectionMode,
	#superclass : #ToListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListMultiSelectionMode >> defaultSelectionCommandChecker [

	^ ToListMultiSelectionCommandChecker new
]

{ #category : #accessing }
ToListMultiSelectionMode >> nodeEventHandlerClasses [ 

	^ { ToListNodeMultiSelectionClickEventHandler }
]

{ #category : #'event handling' }
ToListMultiSelectionMode >> onClickOnNode: aNode event: anEvent [

	anEvent sourceEvent modifiers isShift ifTrue: [
		self selectToIndex: aNode holder position.
		^ self selecter apply ].
	anEvent sourceEvent modifiers isPrimaryModifier ifTrue: [
		| index target |
		index := aNode holder position.
		target := anEvent listElement.
		(target selectionModel containsIndex: index)
			ifTrue: [ self selecter deselectIndex: index ]
			ifFalse: [ self selecter selectIndex: index ].
		^ self selecter apply ].
	self selecter
		selectOnlyIndex: aNode holder position;
		apply
]

{ #category : #shortcuts }
ToListMultiSelectionMode >> selectOrDeselectNextIn: anElement event: aShortcutEvent [

	self selectionModel currentIndex < self itemCount ifFalse: [ ^ self ].
	self selectOrDeselectWithGap: 1.
	self selecter apply.
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self selectionModel currentIndex
]

{ #category : #shortcuts }
ToListMultiSelectionMode >> selectOrDeselectPreviousIn: anElement event: aShortcutEvent [

	self selectionModel currentIndex <= 1 ifTrue: [ ^ self ].
	self selectOrDeselectWithGap: -1.
	self selecter apply.
	self selectionModel isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self selectionModel currentIndex
]

{ #category : #shortcuts }
ToListMultiSelectionMode >> selectOrDeselectWithGap: aGap [

	| nextIdx prevDistance deselect currDistance |
	self selectionModel checkPivot.

	prevDistance := self selectionModel distance.
	nextIdx := self selectionModel currentIndex + aGap.
	self selectionModel distance: self selectionModel pivot - nextIdx.

	deselect := (prevDistance abs - self selectionModel distance abs) ~= -1.
	deselect
		ifTrue: [
			| idx |
			idx := nextIdx - aGap.
			currDistance := self selectionModel distance.
			self selecter deselectIndex: idx.
			self selectionModel distance: currDistance ]
		ifFalse: [
			[
			currDistance := self selectionModel distance.
			self selecter selectIndex: nextIdx.
			self selectionModel distance: currDistance.
			nextIdx < self itemCount and: [
				nextIdx > 1 and: [ self selectionModel containsIndex: nextIdx + aGap ] ] ] whileTrue: [
				nextIdx := nextIdx + aGap.
				self selectionModel distance: self selectionModel distance - aGap ] ].
	self selecter apply.
	self selectionModel currentIndex: nextIdx
]

{ #category : #shortcuts }
ToListMultiSelectionMode >> selectToIndex: index [

	| curr |
	curr := self selectionModel currentIndex.
	self selecter selectIndex: curr to: index.
	self selecter apply.
	self selectionModel markPointedPosition: index.
	self selectionModel pivot: curr.
	self selectionModel distance: index - curr.
]

{ #category : #shortcuts }
ToListMultiSelectionMode >> shortcutsIn: anElement [

	^ (super shortcutsIn: anElement) , {
		  (BlShortcutWithAction new
			   combination: BlKeyCombination primaryA;
			   action: [ :aShortcutEvent :aShortcut |
				   self selecter
					   selectAll;
					   apply ]).
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
