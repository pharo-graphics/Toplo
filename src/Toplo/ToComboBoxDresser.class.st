Class {
	#name : #ToComboBoxDresser,
	#superclass : #ToDresser,
	#instVars : [
		'clickOnDataHandler',
		'crShortcut',
		'escShortcut'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	anElement vFitContent.
	anElement hMatchParent.
	anElement listElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).

	clickOnDataHandler := BlEventHandler
		                      on: ToInfiniteClickOnDataEvent
		                      do: [ :event |
		                      anElement clickOnDataEvent: event ].
	anElement listElement infinite addEventHandler: clickOnDataHandler.

	crShortcut := BlShortcutWithAction new
		              combination:
			              (BlKeyCombination primaryReturn or:
					               BlKeyCombination return);
		              action: [
			              anElement listElement primarySelectionIndexes ifNotEmpty: [
					              :idxes |
					              anElement selectIndex: idxes first.
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
	anElement listElement removeEventHandler: clickOnDataHandler.
	anElement listElement removeShortcut: crShortcut.
	anElement listElement removeShortcut: escShortcut
]
