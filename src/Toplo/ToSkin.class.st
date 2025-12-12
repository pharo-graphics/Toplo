Class {
	#name : #ToSkin,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core-Skin'
}

{ #category : #'state  application dispatch' }
ToSkin >> applyEnqueuedStatesFor: anElement [
	" run the skin actually by flushing the state queue"

	anElement skinManagerDo: [ :sm |
		sm skinStateQueue applyEnqueuedStatesFor: anElement ]
]

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

{ #category : #testing }
ToSkin >> isThemeSkin [

	^ true
]

{ #category : #testing }
ToSkin >> isUnknownSkin [

	^ false
]

{ #category : #testing }
ToSkin >> isUnresolvedSkin [

	^ false
]

{ #category : #'t - styleSheet theme - accessing writable properties' }
ToSkin >> setUpforElement: anElement inTheme: aTheme [

	
]
