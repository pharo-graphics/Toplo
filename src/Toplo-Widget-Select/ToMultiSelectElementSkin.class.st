Class {
	#name : #ToMultiSelectElementSkin,
	#superclass : #ToSelectElementSkin,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'accessing - shortcuts' }
ToMultiSelectElementSkin >> shortcutsToInstallIn: aSelect [

	| listElement |
	listElement := aSelect listElement.

	^ Array streamContents: [ :stream |
		  stream nextPutAll: (super shortcutsToInstallIn: aSelect).
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
					   listElement secondarySelecter scrollToDataSourcePosition: idx ]).

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder shift arrowUp build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := listElement secondarySelecter
						          previousSelectableIndexToScrollTo.
					   listElement secondarySelecter selectIndex: idx.
					   listElement secondarySelecter scrollToDataSourcePosition: idx ]) ]
]
