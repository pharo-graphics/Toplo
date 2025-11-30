Class {
	#name : #ToSelectElementSkin,
	#superclass : #ToListElementSkin,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'event handling' }
ToSelectElementSkin >> closedSkinEvent: anEvent [

	super closedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e iconContainer dispatchEvent: anEvent copy ]
]

{ #category : #'event handling' }
ToSelectElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e padding: (BlInsets
						 horizontal: (e valueOfTokenNamed: #'padding-XS')
						 vertical: (e valueOfTokenNamed: #'padding-content-VS')) ]
]

{ #category : #'event handling' }
ToSelectElementSkin >> openedSkinEvent: anEvent [

	super openedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e iconContainer dispatchEvent: anEvent copy ]
]

{ #category : #'accessing - shortcuts' }
ToSelectElementSkin >> shortcutsToInstallIn: aSelect [

	| listElement |
	listElement := aSelect popupListElement.

	^ Array streamContents: [ :stream |
		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowDown build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := listElement secondarySelecter
						          nextSelectableIndexToScrollTo.
					   listElement secondarySelecter selectOnlyIndex: idx.
					   listElement secondarySelecter scrollToDataSourcePosition: idx.
					   aSelect manager popupEvent: aShortcutEvent ]).

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
					   | selIdxes deselIdxes cmd |
					   selIdxes := OrderedCollection new.
					   deselIdxes := OrderedCollection new.
					   listElement secondarySelectionModel selectedIndexesDo: [ :idx |
							   (listElement selectionModel hiddenSelectionModel
								    containsIndex: idx) ifFalse: [
									   (listElement selectionModel containsIndex: idx)
										   ifTrue: [ deselIdxes add: idx ]
										   ifFalse: [ selIdxes add: idx ] ] ].
					   " use a composite command to have only one ToSelectChangedEvent for multiple sub-commands "
					   cmd := ToListElementCompositeCommand new.
					   aSelect isMultipleSelection ifFalse: [
							   aSelect allowDeselection
								   ifTrue: [ cmd addCommand: ToWholeSelectionCommand remove ]
								   ifFalse: [
									   selIdxes ifNotEmpty: [
											   (listElement selecter containsIndex: selIdxes first)
												   ifFalse: [ cmd addCommand: ToWholeSelectionCommand remove ] ] ] ].
					   aSelect allowDeselection ifTrue: [
							   cmd addCommand: (ToIndexesSelectionCommand remove: deselIdxes) ].
					   cmd addCommand: (ToIndexesSelectionCommand add: selIdxes).
					   listElement selecter addCommand: cmd ]) ]
]

{ #category : #'event handling' }
ToSelectElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]
