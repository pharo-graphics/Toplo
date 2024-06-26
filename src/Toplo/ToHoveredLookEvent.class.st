Class {
	#name : #ToHoveredLookEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToHoveredLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToHoveredLookEvent >> sendTo: anObject [

	anObject hoveredSkinEvent: self
]
