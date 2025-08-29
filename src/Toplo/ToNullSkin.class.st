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

{ #category : #adding }
ToNullSkin >> addSkinStateGeneration: aValuable for: anElement [

	" nothing to do "
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
