Class {
	#name : #ToSkinManagerEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core-Skin'
}

{ #category : #enablement }
ToSkinManagerEventHandler >> enablementChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	"target isFocused ifTrue: [ 'enablementChangedEvent:' trace. target traceCr. target loseFocus ]."
	target requestNewSkin
]

{ #category : #'api - accessing' }
ToSkinManagerEventHandler >> eventsToHandle [

	^ { ToEnablementChangedEvent }
]
