Class {
	#name : #ToSegmentedBarElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #'event handling' }
ToSegmentedBarElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent.
		e primarySelectionMode option animationDuration: 200 milliSeconds.
		e shortcuts: (self shortcutsToInstallIn: e).
		e installShortcuts ]
]

{ #category : #'accessing - shortcuts' }
ToSegmentedBarElementSkin >> shortcutsToInstallIn: aSegmentedBar [

	| listElement |
	listElement := aSegmentedBar.

	^ Array streamContents: [ :stream |
		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowDown build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := listElement secondarySelecter
						          nextSelectableIndexToScrollTo.
					   listElement secondarySelecter selectOnlyIndex: idx.
					   listElement secondarySelecter scrollToDataSourcePosition: idx ]).

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowUp build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := listElement secondarySelecter
						          previousSelectableIndexToScrollTo.
					   listElement secondarySelecter scrollToDataSourcePosition: idx.
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
								
					   listElement selecter selectOnlyIndexes: selIdxes ]) ]
]

{ #category : #'event handling' }
ToSegmentedBarElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e uninstallShortcuts ]
]
