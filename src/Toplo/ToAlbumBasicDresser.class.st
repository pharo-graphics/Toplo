Class {
	#name : #ToAlbumBasicDresser,
	#superclass : #ToDresser,
	#instVars : [
		'infiniteBlurHandler',
		'infiniteFocusedHandler'
	],
	#category : #'Toplo-Widget-Album'
}

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
	^ BlInsets all: 0
]

{ #category : #'api - install/uninstall  hook' }
ToAlbumBasicDresser >> defaultOutskirts [

	^ BlOutskirts inside
]

{ #category : #initialization }
ToAlbumBasicDresser >> defaultPadding [

	^ BlInsets
		  top: (2 + self defaultBorderWidth )
		  left: (3 + self defaultBorderWidth )
		  bottom: (2 + self defaultBorderWidth )
		  right: (2 + self defaultBorderWidth )
]

{ #category : #'api - install/uninstall  hook' }
ToAlbumBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement geometry: self defaultGeometry.
	anElement margin: self defaultMargin.
	anElement padding: self defaultPadding.
	anElement outskirts: self defaultOutskirts.

	infiniteBlurHandler := BlEventHandler
		on: BlBlurEvent
		do: [ :anEvent | 
			anElement border: (BlBorder
					 paint: self defaultBorderColor
					 width: self defaultBorderWidth ) ].

	infiniteFocusedHandler := BlEventHandler
		on:  BlFocusEvent
		do: [ :anEvent | 
			anElement  border: (BlBorder
					 paint: self defaultFocusedBorderColor
					 width: self defaultBorderWidth) ].
	
	anElement infinite addEventHandler: infiniteBlurHandler.
	anElement infinite addEventHandler: infiniteFocusedHandler.
	
	anElement  border: (BlBorder
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
