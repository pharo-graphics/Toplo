Class {
	#name : 'ToSkinManagementEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'enablement' }
ToSkinManagementEventHandler >> enablementChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target enqueueSkinState: (ToEnablementState new enabled: anEvent currentTarget isEnabled yourself)
]

{ #category : 'api - accessing' }
ToSkinManagementEventHandler >> eventsToHandle [

	^ {
		  ToSkinManagementEvent.
		  ToEnablementChangedEvent }
]

{ #category : 'event handling' }
ToSkinManagementEventHandler >> skinInstallStateRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	target skinManager installSkinNow: anEvent skin in: target
]

{ #category : 'event handling' }
ToSkinManagementEventHandler >> skinUninstallStateRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	target skinManager uninstallSkinNow: anEvent skin in: target
]
