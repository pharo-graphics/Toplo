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
	target skinManager installSkinNow: anEvent skin in: target
]

{ #category : 'event handling' }
ToSkinManagementEventHandler >> skinUninstallStateRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	target skinManager uninstallSkinNow: anEvent skin in: target
]
