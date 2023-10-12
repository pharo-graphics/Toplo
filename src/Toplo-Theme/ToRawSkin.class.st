Class {
	#name : #ToRawSkin,
	#superclass : #ToSkin,
	#category : #'Toplo-Theme-Core'
}

{ #category : #'api - install/uninstall  hook' }
ToRawSkin >> onSkinInstalledIn: anElement [

	anElement initializeRawStyle
]
