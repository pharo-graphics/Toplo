Class {
	#name : #ToRawSkin,
	#superclass : #ToGeneralSkin,
	#category : #'Toplo-Theme-Skin'
}

{ #category : #'api - hooks' }
ToRawSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement installRawStyle
]

{ #category : #'api - hooks' }
ToRawSkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement uninstallRawStyle

]
