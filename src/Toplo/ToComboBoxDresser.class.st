Class {
	#name : #ToComboBoxDresser,
	#superclass : #ToDresser,
	#instVars : [
		'clickOnDataHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	clickOnDataHandler := BlEventHandler on: ToInfiniteClickOnDataEvent do: [ :event | anElement clickOnDataEvent: event ].
	anElement listElement addEventHandler: clickOnDataHandler.
	anElement listElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4)
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: clickOnDataHandler
]
