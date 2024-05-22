Class {
	#name : #ToSelectElementSkin,
	#superclass : #ToElementBarSkinDep,
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #'accessing - shortcuts' }
ToSelectElementSkin >> shortcutsToInstallIn: aSelect [

	| listElement |
	listElement := aSelect listElement.

	^ Array streamContents: [ :stream |
		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowDown build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := listElement secondarySelecter
						          nextSelectableIndexToScrollTo.
					   listElement secondarySelecter selectOnlyIndex: idx.
					   listElement secondarySelecter scrollToIndex: idx.
					   aSelect windowManager currentWindow ifNil: [
							   aSelect popupWindowEvent: aShortcutEvent ] ]).

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowUp build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := listElement secondarySelecter
						          previousSelectableIndexToScrollTo.
					   listElement secondarySelecter scrollToIndex: idx.
					   listElement secondarySelecter selectOnlyIndex: idx ]).

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder return build;
				   action: [ :aShortcutEvent :aShortcut |
					   | selIdxes deselIdxes |
					   selIdxes := OrderedCollection new.
					   deselIdxes := OrderedCollection new.
					   listElement secondarySelectionModel selectedIndexesDo: [ :idx |
							   (listElement selectionModel hiddenSelectionModel
								    containsIndex: idx) ifFalse: [
									   (listElement selectionModel containsIndex: idx)
										   ifTrue: [ deselIdxes add: idx ]
										   ifFalse: [ selIdxes add: idx ] ] ].
					   listElement selecter selectIndexes: selIdxes.
					   listElement selecter deselectIndexes: deselIdxes ]).

		  listElement isMultipleSelection ifTrue: [
			  aSelect isFiltrable ifTrue: [
				  stream nextPut: ToSelectTextFieldBackspaceShortcut new ].
			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination primaryA;
					   action: [ :aShortcutEvent :aShortcut |
						   listElement secondarySelecter selectAll ]).

			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowDown build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := listElement secondarySelecter
							          nextSelectableIndexToScrollTo.
						   listElement secondarySelecter selectIndex: idx.
						   listElement secondarySelecter scrollToIndex: idx ]).

			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowUp build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := listElement secondarySelecter
							          previousSelectableIndexToScrollTo.
						   listElement secondarySelecter selectIndex: idx.
						   listElement secondarySelecter scrollToIndex: idx ]) ] ]
]
