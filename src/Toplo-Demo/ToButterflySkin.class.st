Class {
	#name : #ToButterflySkin,
	#superclass : #ToBasicSkin,
	#category : #'Toplo-Demo-2 - ButterflyTheme'
}

{ #category : #'api - hooks' }
ToButterflySkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement installButterflyStyle

]

{ #category : #'api - hooks' }
ToButterflySkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement uninstallButterflyStyle

]
