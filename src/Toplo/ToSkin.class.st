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
ToSkin >> isKnownSkin [

	^ self isUnknownSkin not
]

{ #category : #testing }
ToSkin >> isNullSkin [

	^ false
]

{ #category : #testing }
ToSkin >> isUnknownSkin [

	^ false
]

{ #category : #'t - styleSheet theme - accessing writable properties' }
ToSkin >> setUpforElement: anElement inTheme: aTheme [

	
]
