Class {
	#name : #ToDraggedLookEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToDraggedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToDraggedLookEvent >> sendTo: anObject [

	anObject draggedSkinEvent: self
]
