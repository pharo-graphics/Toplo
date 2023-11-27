Class {
	#name : 'ToRawSkin',
	#superclass : 'ToSkin',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'event dispatch' }
ToRawSkin >> dispatchSkinInstallStateRequestTo: anObject [

	super dispatchSkinInstallStateRequestTo: anObject.
	"anObject installRawStyle"
	
]

{ #category : 'event dispatch' }
ToRawSkin >> dispatchSkinUninstallStateRequestTo: anObject [

	super dispatchSkinUninstallStateRequestTo: anObject.
	"anObject uninstallRawStyle"
	
]

{ #category : 'event dispatch' }
ToRawSkin >> onInstallStateRequestIn: anElement [

	super onInstallStateRequestIn: anElement.
	anElement installRawStyle
	
]

{ #category : 'event dispatch' }
ToRawSkin >> onUninstallStateRequestIn: anElement [

	super onUninstallStateRequestIn: anElement.
	anElement uninstallRawStyle
	
]
