Class {
	#name : #ToSegmentedElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #'event handling' }
ToSegmentedElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-bg-container').
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: #'border-radius')).
		e shortcuts: (self shortcutsToInstallIn: e).
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'border-paint')
				 width: (e valueOfTokenNamed: #'border-width')).
		e installShortcuts ]
]

{ #category : #'accessing - shortcuts' }
ToSegmentedElementSkin >> shortcutsToInstallIn: aSegmentedBar [

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
					   listElement secondarySelectionModel selectedIndexesDo: [ :idx |
							   (listElement dataAccessor at: idx) switchToNextCheckState ] ]) ]
]

{ #category : #'event handling' }
ToSegmentedElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e | e uninstallShortcuts ]
]
