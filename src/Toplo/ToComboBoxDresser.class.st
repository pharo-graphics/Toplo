Class {
	#name : #ToComboBoxDresser,
	#superclass : #ToDresser,
	#instVars : [
		'clickOnDataHandler',
		'crShortcut',
		'escShortcut',
		'structuralChangeHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> checkEmptinessChangeIn: anElement [

	"anElement data ifEmpty: [ ^ self showListPlaceholderIn: anElement ].
	self hideListPlaceholderIn: anElement"
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> hideListPlaceholderIn: anElement [

	anElement prepareListElement 
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	anElement vFitContent.
	anElement hMatchParent.
	anElement listElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	
	structuralChangeHandler := BlEventHandler on: ToListDataEmptinessChangeEvent do: [ :event | self checkEmptinessChangeIn: anElement ].
	clickOnDataHandler := BlEventHandler
		                      on: ToInfiniteClickOnDataEvent
		                      do: [ :event |
		                      anElement clickOnDataEvent: event ].
	anElement listElement infinite addEventHandler: clickOnDataHandler.
	anElement listElement infinite dataSource addEventHandler: structuralChangeHandler.
	
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
	anElement listElement infinite dataSource removeEventHandler: structuralChangeHandler.
	anElement listElement infinite removeEventHandler: clickOnDataHandler.
	anElement listElement removeShortcut: crShortcut.
	anElement listElement removeShortcut: escShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> showListPlaceholderIn: anElement [

	anElement prepareListPlaceHolder 
]
