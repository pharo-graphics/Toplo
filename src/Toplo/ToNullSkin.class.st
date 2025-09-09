Class {
	#name : #ToNullSkin,
	#superclass : #ToSkin,
	#classVars : [
		'Instance'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #accessing }
ToNullSkin class >> instance [ 

	^ Instance ifNil: [ Instance := self new ]
]

{ #category : #'api - accessing' }
ToNullSkin >> eventsToHandle [

	^ {  }
]

{ #category : #'api - event managing' }
ToNullSkin >> handleEvent: anEvent [
]

{ #category : #testing }
ToNullSkin >> isNullSkin [ 

	^ true
]
