Class {
	#name : #ToStandardListSelectionStrategy,
	#superclass : #ToInfiniteSelectionStrategy,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #'selection and shortcuts handlers' }
ToStandardListSelectionStrategy >> defaultShortcuts [

	| shortcuts |
	shortcuts := super defaultShortcuts.
	self isMultiple ifTrue: [
		shortcuts := shortcuts , {
			             (BlShortcutWithAction new
				              combination: BlKeyCombination primaryA;
				              action: [ :aShortcutEvent :aShortcut |
					              infiniteElement dispatchSelectionChangedAfter: [
							              self doSelectAll ] ]).
			             (BlShortcutWithAction new
				              combination: BlKeyCombination shiftArrowDown;
				              action: [ :aShortcutEvent :aShortcut |
					              infiniteElement dispatchSelectionChangedAfter: [
							              self
								              selectNextIn: infiniteElement
								              event: aShortcutEvent ] ]).
			             (BlShortcutWithAction new
				              combination: BlKeyCombination shiftArrowUp;
				              action: [ :aShortcutEvent :aShortcut |
					              infiniteElement dispatchSelectionChangedAfter: [
							              self
								              selectPreviousIn: infiniteElement
								              event: aShortcutEvent ] ]) } ].
	^ shortcuts
]

{ #category : #'selection and shortcuts handlers' }
ToStandardListSelectionStrategy >> installEventHandlersInNewNode: aNode [

	aNode addEventHandler: self newListNodeEventHandler 
]

{ #category : #'selection and shortcuts handlers' }
ToStandardListSelectionStrategy >> newListNodeEventHandler [

	^ ToStandardNodeSelectionEventHandler new
]
