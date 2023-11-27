Class {
	#name : 'ToBeeSkin',
	#superclass : 'ToStyleSheetSkin',
	#category : 'Toplo-Theme-Bee',
	#package : 'Toplo-Theme-Bee'
}

{ #category : 'event dispatch' }
ToBeeSkin >> onInstallStateRequestIn: anElement [

	super onInstallStateRequestIn: anElement.
	anElement installBeeStyle
	
]

{ #category : 'event dispatch' }
ToBeeSkin >> onUninstallStateRequestIn: anElement [

	super onUninstallStateRequestIn: anElement.
	anElement uninstallBeeStyle
	
]
