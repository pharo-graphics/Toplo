Class {
	#name : #ToCherryPickListSelectionStrategy,
	#superclass : #ToInfiniteSelectionStrategy,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #'selection and shortcuts handlers' }
ToCherryPickListSelectionStrategy >> defaultShortcuts [

	| shortcuts |
	shortcuts := super defaultShortcuts.
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
ToCherryPickListSelectionStrategy >> nodeEventHandlerClasses [

	^ { ToCherryPickOnMouseDownEventHandler }
]
