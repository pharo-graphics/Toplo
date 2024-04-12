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

	^ { ToEnablementChangedEvent }
]
