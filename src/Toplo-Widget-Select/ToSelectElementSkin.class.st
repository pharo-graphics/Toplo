Class {
	#name : #ToSelectElementSkin,
	#superclass : #ToGeneralButtonSkin,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'event handling' }
ToSelectElementSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToSelectElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e shortcuts: (self shortcutsToInstallIn: e).
		e installShortcuts ]
]

{ #category : #'accessing - shortcuts' }
ToSelectElementSkin >> shortcutsToInstallIn: aSelect [

	| listElement |
	listElement := aSelect listElement.

	^ Array streamContents: [ :stream |
		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowDown build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := listElement secondarySelecter nextSelectableIndexToScrollTo.
					   listElement secondarySelecter selectOnlyIndex: idx.
					   listElement secondarySelecter scrollToIndex: idx.
					   aSelect windowManager currentWindow ifNil: [
							   aSelect popupWindowEvent: aShortcutEvent ] ]).

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowUp build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := listElement secondarySelecter previousSelectableIndexToScrollTo.
					   listElement secondarySelecter scrollToIndex: idx.
					   listElement secondarySelecter selectOnlyIndex: idx ]).

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder return build;
				   action: [ :aShortcutEvent :aShortcut |
					   listElement secondarySelectionModel selectedIndexesDo: [ :idx |
							   (listElement selectionModel containsIndex: idx)
								   ifTrue: [ listElement selecter deselectIndex: idx ]
								   ifFalse: [ listElement selecter selectIndex: idx ] ] ]).

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
						   idx := listElement secondarySelecter nextSelectableIndexToScrollTo.
						   listElement secondarySelecter selectIndex: idx.
						   listElement secondarySelecter scrollToIndex: idx ]).

			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowUp build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := listElement secondarySelecter previousSelectableIndexToScrollTo.
						   listElement secondarySelecter selectIndex: idx.
						   listElement secondarySelecter scrollToIndex: idx ]) ] ]
]

{ #category : #'event handling' }
ToSelectElementSkin >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e uninstallShortcuts ]
]
