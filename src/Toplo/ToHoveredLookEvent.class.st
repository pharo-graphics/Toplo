Class {
	#name : #ToHoveredLookEvent,
	#superclass : #ToTransientLookEvent,
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToHoveredLookEvent >> sendTo: anObject [

	anObject hoveredLookEvent: self
]
