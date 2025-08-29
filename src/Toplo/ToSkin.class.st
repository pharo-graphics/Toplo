Class {
	#name : #ToSkin,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core-Skin'
}

{ #category : #adding }
ToSkin >> addSkinStateGeneration: aValuable for: anElement [

	" add a skin generation action to be evaluated by the states application phase "
	(anElement isAttachedToSceneGraph)
		ifTrue: [ anElement space addSkinStateGeneration: aValuable ]
		ifFalse: aValuable
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
