Class {
	#name : 'ToRawSkin',
	#superclass : 'ToSkin',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'event dispatch' }
ToRawSkin >> dispatchSkinInitialStateRequestTo: anObject [

	super dispatchSkinInitialStateRequestTo: anObject.
	anObject initialRawStyle
	
]

{ #category : 'event dispatch' }
ToRawSkin >> dispatchSkinInstallStateRequestTo: anObject [

	super dispatchSkinInstallStateRequestTo: anObject.
	anObject installRawStyle
	
]

{ #category : 'event dispatch' }
ToRawSkin >> dispatchSkinUninstallStateRequestTo: anObject [

	super dispatchSkinUninstallStateRequestTo: anObject.
	anObject uninstallRawStyle
	
]
