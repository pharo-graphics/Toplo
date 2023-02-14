Class {
	#name : #ToTextFieldDresser,
	#superclass : #ToAlbumBasicDresser,
	#instVars : [
		'selectionHandler',
		'doubleClickHandler',
		'mouseDownHandler',
		'mouseUpHandler'
	],
	#category : #'Toplo-Widget-TextField'
}

{ #category : #'api - install/uninstall  hook' }
ToTextFieldDresser >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 4
]

{ #category : #'api - install/uninstall  hook' }
ToTextFieldDresser >> defaultMargin [

	^ BlInsets all: 2
]

{ #category : #'api - install/uninstall  hook' }
ToTextFieldDresser >> defaultPadding [

	^ BlInsets empty
]

{ #category : #'api - install/uninstall  hook' }
ToTextFieldDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	selectionHandler := AlbTextEditorSelectionHandler new element: anElement infinite.
	doubleClickHandler := AlbTextEditorDoubleClickHandler new element: anElement infinite.
	mouseDownHandler := BlEventHandler
				on: BlMouseDownEvent 
				do: [ :evt | anElement infinite dispatchEvent: evt ].
	mouseUpHandler := BlEventHandler
				on: BlMouseUpEvent 
				do: [ :evt | anElement infinite dispatchEvent: evt ].
				
	anElement addEventHandler: selectionHandler.
	anElement addEventHandler: doubleClickHandler.
	anElement addEventHandler: mouseDownHandler.
	anElement addEventHandler: mouseUpHandler

]

{ #category : #'api - install/uninstall  hook' }
ToTextFieldDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: selectionHandler.
	anElement removeEventHandler: doubleClickHandler.
	anElement removeEventHandler: mouseDownHandler.
	anElement removeEventHandler: mouseUpHandler
]
