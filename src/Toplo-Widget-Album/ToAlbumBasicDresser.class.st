Class {
	#name : #ToAlbumBasicDresser,
	#superclass : #ToDresser,
	#instVars : [
		'infiniteBlurHandler',
		'infiniteFocusedHandler'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'api - install/uninstall  hook' }
ToAlbumBasicDresser >> checkTextIn: anEditorElement [

	anEditorElement text
		ifEmpty: [ anEditorElement showPlaceholder ]
		ifNotEmpty: [ anEditorElement hidePlaceholder ]
]

{ #category : #initialization }
ToAlbumBasicDresser >> defaultBackground [

	^ Color white
]

{ #category : #initialization }
ToAlbumBasicDresser >> defaultBorderColor [ 

	^ self theme editor borderColor
]

{ #category : #initialization }
ToAlbumBasicDresser >> defaultBorderWidth [ 

	^ 1
]

{ #category : #initialization }
ToAlbumBasicDresser >> defaultFocusedBorderColor [

	^ self theme editor focusedBorderColor
]

{ #category : #'api - install/uninstall  hook' }
ToAlbumBasicDresser >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 8
]

{ #category : #initialization }
ToAlbumBasicDresser >> defaultMargin [

	"setup to not depend on parent layout"
	^ BlInsets all: 1
]

{ #category : #'api - install/uninstall  hook' }
ToAlbumBasicDresser >> defaultOutskirts [

	^ BlOutskirts inside
]

{ #category : #initialization }
ToAlbumBasicDresser >> defaultPadding [

	^ BlInsets
		  top: (6 + self defaultBorderWidth )
		  left: (3 + self defaultBorderWidth )
		  bottom: (2 + self defaultBorderWidth )
		  right: (3 + self defaultBorderWidth )
]

{ #category : #'api - install/uninstall  hook' }
ToAlbumBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement geometry: self defaultGeometry.
	anElement innerElement outskirts: self defaultOutskirts.
	anElement innerElement geometry: self defaultGeometry.
	anElement innerElement margin: self defaultMargin.
	anElement innerElement padding: self defaultPadding.
	
	" add/remove placeholder according to unaccepted text size"
	anElement whenTextEditedDo: [ self checkTextIn: anElement ].
	anElement whenTextReplacedDo: [ self checkTextIn: anElement ].
	
	infiniteBlurHandler := BlEventHandler
		on: BlBlurEvent
		do: [ :anEvent | 
			anElement border: (BlBorder
					 paint: self defaultBorderColor
					 width: self defaultBorderWidth ) ].

	infiniteFocusedHandler := BlEventHandler
		on:  BlFocusEvent
		do: [ :anEvent | 
			anElement border: (BlBorder
					 paint: self defaultFocusedBorderColor
					 width: self defaultBorderWidth) ].
	
	anElement infinite addEventHandler: infiniteBlurHandler.
	anElement infinite addEventHandler: infiniteFocusedHandler.
	
	anElement border: (BlBorder
			 paint: self defaultBorderColor
			 width: self defaultBorderWidth).

	anElement  background: self defaultBackground 
]

{ #category : #'api - install/uninstall  hook' }
ToAlbumBasicDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement infinite removeEventHandler: infiniteBlurHandler.
	anElement infinite removeEventHandler: infiniteFocusedHandler.

]
