Class {
	#name : 'ToInitialLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToInitialLookEvent >> sendTo: anObject [

	anObject initialLookEvent: self
]
