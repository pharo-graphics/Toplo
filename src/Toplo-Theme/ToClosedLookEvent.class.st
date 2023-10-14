Class {
	#name : 'ToClosedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToClosedLookEvent >> sendTo: anObject [

	anObject closedLookEvent: self
]
