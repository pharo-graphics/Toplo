Class {
	#name : 'ToSkinManagementEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'api - accessing' }
ToSkinManagementEventHandler >> eventsToHandle [

	^ { ToSkinManagementEvent }
]

{ #category : 'event handling' }
ToSkinManagementEventHandler >> skinInstallStateRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	anEvent skin onInstallStateRequestIn: target.
	target skinStateQueue skinInstallStateRequestIn: target

]

{ #category : 'event handling' }
ToSkinManagementEventHandler >> skinUninstallStateRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	anEvent skin onUninstallStateRequestIn: target.
	target skinStateQueue skinUninstallStateRequestIn: target.

]
