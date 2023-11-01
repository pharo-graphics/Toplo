Class {
	#name : 'ToHoveredLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToHoveredLookEvent >> sendTo: anObject [

	anObject hoveredLookEvent: self
]
