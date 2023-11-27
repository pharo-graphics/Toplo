Class {
	#name : 'ToBeeSkin',
	#superclass : 'ToStyleSheetSkin',
	#category : 'Toplo-Theme-Bee',
	#package : 'Toplo-Theme-Bee'
}

{ #category : 'event dispatch' }
ToBeeSkin >> dispatchSkinInstallStateRequestTo: anObject [

	super dispatchSkinInstallStateRequestTo: anObject.
	"anObject installBeeStyle"
	
]

{ #category : 'event dispatch' }
ToBeeSkin >> dispatchSkinUninstallStateRequestTo: anObject [

	super dispatchSkinUninstallStateRequestTo: anObject.
	"anObject uninstallBeeStyle"
	
]

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
