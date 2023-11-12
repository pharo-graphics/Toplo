Class {
	#name : #ToHoveredLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToHoveredLookEvent >> sendTo: anObject [

	anObject hoveredLookEvent: self
]
