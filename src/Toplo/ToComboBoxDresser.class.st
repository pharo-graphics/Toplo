Class {
	#name : #ToComboBoxDresser,
	#superclass : #ToDresser,
	#instVars : [
		'clickOnDataHandler',
		'crShortcut',
		'escShortcut',
		'structuralChangeHandler',
		'placeholderAddedHandler',
		'placeholderRemovedHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> hideListPlaceholderIn: anElement [

	anElement placeholderHidden 
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	anElement vFitContent.
	anElement hMatchParent.
	anElement listElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	
	placeholderAddedHandler := BlEventHandler on: ToPlaceholderAddedEvent  do: [ :event | self showListPlaceholderIn: anElement ].
	placeholderRemovedHandler := BlEventHandler on: ToPlaceholderRemovedEvent  do: [ :event | self hideListPlaceholderIn: anElement ].
	
	clickOnDataHandler := BlEventHandler
		                      on: ToInfiniteClickOnDataEvent
		                      do: [ :event |
		                      anElement clickOnDataEvent: event ].
	
	anElement listElement infinite addEventHandler: clickOnDataHandler.
	anElement listElement addEventHandler: placeholderAddedHandler.
	anElement listElement addEventHandler: placeholderRemovedHandler.
	
	crShortcut := BlShortcutWithAction new
		              combination:
			              (BlKeyCombination primaryReturn or:
					               BlKeyCombination return);
		              action: [
			              anElement listElement primarySelectionIndexes ifNotEmpty: [
					              :idxes |
					              anElement selectIndexInPresentedData: idxes first.
					              anElement closeEvent: nil.
					              anElement requestFocus ] ];
		              name: 'Accept';
		              yourself.
	escShortcut := BlShortcutWithAction new
		               combination: BlKeyCombination escape;
		               action: [
			               anElement closeEvent: nil.
			               anElement requestFocus ];
		               name: 'Escape';
		               yourself.
	anElement listElement addShortcut: crShortcut.
	anElement listElement addShortcut: escShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement listElement removeEventHandler: placeholderAddedHandler.
	anElement listElement removeEventHandler: placeholderRemovedHandler.
	anElement listElement infinite removeEventHandler: clickOnDataHandler.
	anElement listElement removeShortcut: crShortcut.
	anElement listElement removeShortcut: escShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> showListPlaceholderIn: anElement [

	anElement placeholderShown
]
