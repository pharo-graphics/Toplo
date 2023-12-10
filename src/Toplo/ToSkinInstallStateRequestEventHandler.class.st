Class {
	#name : 'ToSkinInstallStateRequestEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'enablement' }
ToSkinInstallStateRequestEventHandler >> enablementChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target requestNewSkin
]

{ #category : 'api - accessing' }
ToSkinInstallStateRequestEventHandler >> eventsToHandle [

	^ {
		  ToSkinManagementEvent.
		  ToEnablementChangedEvent }
]

{ #category : 'event handling' }
ToSkinInstallStateRequestEventHandler >> skinInstallStateRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	target skinManager installSkinNow: anEvent skin in: target
]

{ #category : 'event handling' }
ToSkinInstallStateRequestEventHandler >> skinUninstallStateRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	target skinManager uninstallSkinNow: anEvent skin in: target
]
