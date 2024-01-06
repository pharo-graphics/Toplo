Class {
	#name : #ToSkinManagerEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core-Skin'
}

{ #category : #enablement }
ToSkinManagerEventHandler >> enablementChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target requestNewSkin
]

{ #category : #'api - accessing' }
ToSkinManagerEventHandler >> eventsToHandle [

	^ {
		  ToSkinManagementEvent.
		  ToEnablementChangedEvent }
]

{ #category : #'event handling' }
ToSkinManagerEventHandler >> skinInstallStateRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	target skinManager installSkinNow: anEvent skin in: target
]

{ #category : #'event handling' }
ToSkinManagerEventHandler >> skinUninstallStateRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	target skinManager uninstallSkinNow: anEvent skin in: target
]
