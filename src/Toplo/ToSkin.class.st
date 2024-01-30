Class {
	#name : #ToSkin,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core-Skin'
}

{ #category : #'api - accessing' }
ToSkin >> eventsToHandle [

	^ { ToElementLookEvent }
]

{ #category : #testing }
ToSkin >> isNullSkin [

	^ false
]
