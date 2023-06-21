Class {
	#name : #ToComboBoxDresser,
	#superclass : #ToDresser,
	#instVars : [
		'crShortcut',
		'escShortcut',
		'placeholderAddedHandler',
		'placeholderRemovedHandler',
		'nodeClickHandler'
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
	nodeClickHandler := BlEventHandler on: BlClickEvent do: [ :event | anElement listClickedEvent: event ].
	
	anElement listElement addEventHandler: placeholderAddedHandler.
	anElement listElement addEventHandler: placeholderRemovedHandler.
	anElement listElement addEventHandler: nodeClickHandler
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement listElement removeEventHandler: placeholderAddedHandler.
	anElement listElement removeEventHandler: placeholderRemovedHandler.
	anElement listElement removeEventHandler: nodeClickHandler.
	"anElement listElement removeShortcut: crShortcut.
	anElement listElement removeShortcut: escShortcut"
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxDresser >> showListPlaceholderIn: anElement [

	anElement placeholderShown
]
