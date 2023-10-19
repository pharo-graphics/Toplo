Class {
	#name : #ToNullSkin,
	#superclass : #ToSkin,
	#category : 'Toplo-Core-Skin'
}

{ #category : #testing }
ToNullSkin >> isNullSkin [ 

	^ true
]

{ #category : #'api - event managing' }
ToNullSkin >> wantsEvent: anEvent [

	^ false
]
