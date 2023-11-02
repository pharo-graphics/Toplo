Class {
	#name : 'ToStillHoveredLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToStillHoveredLookEvent >> sendTo: anObject [

	anObject stillHoveredLookEvent: self
]
