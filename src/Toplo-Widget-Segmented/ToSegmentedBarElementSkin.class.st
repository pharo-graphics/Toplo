Class {
	#name : #ToSegmentedBarElementSkin,
	#superclass : #ToItemBarElementSkin,
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #'accessing - shortcuts' }
ToSegmentedBarElementSkin >> shortcutsToInstallIn: aSegmentedBar [

	^ Array
		  streamContents: [ :stream |
			stream nextPutAll: (super shortcutsToInstallIn: aSegmentedBar).
			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder return build;
					   action: [ :aShortcutEvent :aShortcut |
						   aSegmentedBar secondarySelectionModel selectedIndexesDo: [ :idx |
								   (aSegmentedBar dataAccessor at: idx) switchToNextCheckState ] ]) ]
]
