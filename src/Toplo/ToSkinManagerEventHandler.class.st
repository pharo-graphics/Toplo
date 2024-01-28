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
ToSkinManagerEventHandler >> installSkinEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target skinManager installSkin: anEvent skin in: target
]

{ #category : #'event handling' }
ToSkinManagerEventHandler >> uninstallSkinEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target skinManager uninstallSkin: anEvent skin in: target
]
