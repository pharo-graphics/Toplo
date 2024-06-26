Class {
	#name : #ToDroppedLookEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToDroppedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToDroppedLookEvent >> sendTo: anObject [

	anObject droppedSkinEvent: self
]
