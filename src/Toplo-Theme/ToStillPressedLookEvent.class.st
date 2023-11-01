Class {
	#name : 'ToStillPressedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToStillPressedLookEvent >> sendTo: anObject [

	anObject stillPressedLookEvent: self
]
