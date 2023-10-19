Class {
	#name : #ToHoveredLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToHoveredLookEvent >> sendTo: anObject [

	anObject hoveredLookEvent: self
]
