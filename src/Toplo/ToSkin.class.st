Class {
	#name : #ToSkin,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core-Skin'
}

{ #category : #'api - accessing' }
ToSkin >> eventsToHandle [

	^ { ToSkinEvent }
]

{ #category : #testing }
ToSkin >> isNullSkin [

	^ false
]
