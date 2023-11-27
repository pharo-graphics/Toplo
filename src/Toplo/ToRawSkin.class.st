Class {
	#name : 'ToRawSkin',
	#superclass : 'ToSkin',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

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
