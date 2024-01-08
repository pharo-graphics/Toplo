Class {
	#name : #ToCherryPickListSelectionStrategy,
	#superclass : #ToListSelectionStrategy,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #'selection and shortcuts handlers' }
ToCherryPickListSelectionStrategy >> installEventHandlersInNewNode: aNode [

	aNode addEventHandler: self newListNodeEventHandler 
]

{ #category : #'selection and shortcuts handlers' }
ToCherryPickListSelectionStrategy >> newListNodeEventHandler [

	^ ToCherryPickOnMouseDownEventHandler new
]

{ #category : #shortcuts }
ToCherryPickListSelectionStrategy >> selectNextIn: anElement event: aShortcutEvent [

	aShortcutEvent modifiers isShift
		ifTrue: [ self addOrRemoveNext ]
		ifFalse: [ self selectNext ].
	self isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex
]

{ #category : #shortcuts }
ToCherryPickListSelectionStrategy >> selectPreviousIn: anElement event: aShortcutEvent [

	aShortcutEvent modifiers isShift
		ifTrue: [ self addOrRemovePrevious ]
		ifFalse: [ self selectPrevious ].
	self isEmpty ifTrue: [ ^ self ].
	anElement scrollToIndex: self currentIndex 
]

{ #category : #'selection and shortcuts handlers' }
ToCherryPickListSelectionStrategy >> shortcuts [

	| shortcuts |
	shortcuts := {
		             (BlShortcutWithAction new
			              combination: BlKeyCombination builder arrowDown build;
			              action: [ :aShortcutEvent :aShortcut |
				              infiniteElement dispatchSelectionChangedAfter: [
						              self selectNextIn: infiniteElement event: aShortcutEvent ] ]).
		             (BlShortcutWithAction new
			              combination: BlKeyCombination builder arrowUp build;
			              action: [ :aShortcutEvent :aShortcut |
				              infiniteElement dispatchSelectionChangedAfter: [
						              self selectPreviousIn: infiniteElement event: aShortcutEvent ] ]) }.
	self isMultiple ifTrue: [
		shortcuts := shortcuts , {
			             (BlShortcutWithAction new
				              combination: BlKeyCombination primaryA;
				              action: [ :aShortcutEvent :aShortcut |
					              infiniteElement dispatchSelectionChangedAfter: [
							              self selectAll ] ]).
			             (BlShortcutWithAction new
				              combination: BlKeyCombination shiftArrowDown;
				              action: [ :aShortcutEvent :aShortcut |
					              infiniteElement dispatchSelectionChangedAfter: [
							              self selectNextIn: infiniteElement event: aShortcutEvent ] ]).
			             (BlShortcutWithAction new
				              combination: BlKeyCombination shiftArrowUp;
				              action: [ :aShortcutEvent :aShortcut |
					              infiniteElement dispatchSelectionChangedAfter: [
							              self
								              selectPreviousIn: infiniteElement
								              event: aShortcutEvent ] ]) } ].
	^ shortcuts
]
