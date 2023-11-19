Class {
	#name : #ToNullSkin,
	#superclass : #ToSkin,
	#category : 'Toplo-Core-Theme'
}

{ #category : #'style updating' }
ToNullSkin >> applyStylesIn: anElement [
]

{ #category : #'api - accessing' }
ToNullSkin >> eventsToHandle [

	^ {  }
]

{ #category : #testing }
ToNullSkin >> isNullSkin [ 

	^ true
]
