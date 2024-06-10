Class {
	#name : #ToSegmentedSelectionMode,
	#superclass : #ToListSelectionMode,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'event handling' }
ToSegmentedSelectionMode >> onClickEvent: anEvent onNode: aNode [
	" implement the default/standard selection/deselection protocol"

	self isDisabled ifTrue: [ ^ self ].

	" Multiple selection "
	self isMultipleSelection ifTrue: [ " SHIFT "
		anEvent sourceEvent modifiers isShift ifTrue: [
			| curr |
			curr := self selecter currentIndex.
			self selecter selectIndex: curr to: aNode holder position.
			^ self ].
		" CMD-CTRL "
		(anEvent sourceEvent modifiers isPrimaryModifier or: [
			 self selectOnMouseDown ]) ifTrue: [
			self selectOrDeselectOnNode: aNode.
			^ self ].
		" No modifier"
		self selecter selectOnlyIndex: aNode holder position.
		^ self ].

	" Single selection "
	" CMD-CTRL  "
	(anEvent sourceEvent modifiers isPrimaryModifier or: [
		 self selectOnMouseDown ]) ifTrue: [
		| index |
		index := aNode holder position.
		(self selectionModel containsIndex: index) ifTrue: [
			^ self selecter deselectIndex: index ] ].

	" No modifier"
	self selecter selectOnlyIndex: aNode holder position
]
