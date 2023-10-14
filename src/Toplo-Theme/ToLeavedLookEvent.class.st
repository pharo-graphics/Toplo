Class {
	#name : 'ToLeavedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToLeavedLookEvent >> sendTo: anObject [

	anObject leavedLookEvent: self
]
