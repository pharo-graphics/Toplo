Class {
	#name : 'ToBeeSkin',
	#superclass : 'ToStyleSheetSkin',
	#category : 'Toplo-Theme-Bee',
	#package : 'Toplo-Theme-Bee'
}

{ #category : 'api - hooks' }
ToBeeSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement installBeeStyle
	
]

{ #category : 'api - hooks' }
ToBeeSkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement uninstallBeeStyle
	
]
