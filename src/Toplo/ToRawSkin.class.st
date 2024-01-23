Class {
	#name : #ToRawSkin,
	#superclass : #ToBasicSkin,
	#category : #'Toplo-Core-Skin'
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
