Class {
	#name : #ToSkin,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core-Skin'
}

{ #category : #'api - accessing' }
ToSkin >> eventsToHandle [

	^ { ToSkinEvent }
]

{ #category : #'api - event managing' }
ToSkin >> handleEvent: anEvent [

	anEvent sendToSkin: self
]

{ #category : #testing }
ToSkin >> isNullSkin [

	^ false
]
