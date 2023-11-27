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
	target addEventHandler: anEvent skin.
	anEvent skin onInstallStateRequestIn: target.
	"'ToSkinManagementEventHandler>>skinInstallStateRequest: ' traceCr."
	target skinStateQueue onSkinInstallStateRequestIn: target

]

{ #category : 'event handling' }
ToSkinManagementEventHandler >> skinUninstallStateRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	"'		ToSkinManagementEventHandler>>skinUninstallStateRequest: ' traceCr."
	anEvent skin onUninstallStateRequestIn: target.
	target skinStateQueue onSkinUninstallStateRequestIn: target.
	target removeEventHandler: anEvent skin

]
