Class {
	#name : #ToNullSkin,
	#superclass : #ToSkin,
	#category : 'Toplo-Core-Theme'
}

{ #category : #'api - accessing' }
ToNullSkin >> eventsToHandle [

	^ {
		  ToSkinEvent }
]

{ #category : #testing }
ToNullSkin >> isNullSkin [ 

	^ true
]

{ #category : #'style updating' }
ToNullSkin >> updateStylesIn: anElement [
]
