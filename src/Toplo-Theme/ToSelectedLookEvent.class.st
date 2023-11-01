Class {
	#name : 'ToSelectedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToSelectedLookEvent >> sendTo: anObject [

	anObject selectedLookEvent: self
]
