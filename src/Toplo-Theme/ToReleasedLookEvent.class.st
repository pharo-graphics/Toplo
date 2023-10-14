Class {
	#name : 'ToReleasedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToReleasedLookEvent >> sendTo: anObject [

	anObject releasedLookEvent: self
]
