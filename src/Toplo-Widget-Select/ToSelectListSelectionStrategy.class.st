Class {
	#name : #ToSelectListSelectionStrategy,
	#superclass : #ToInfiniteSelectionStrategy,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'selection and shortcuts handlers' }
ToSelectListSelectionStrategy >> defaultShortcuts [

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
ToSelectListSelectionStrategy >> nodeEventHandlerClasses [

	^ { ToSelectListNodeEventHandler }
]
