Class {
	#name : 'ToRawSkin',
	#superclass : 'ToSkin',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
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
