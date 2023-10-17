Class {
	#name : 'ToUnabledLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToUnabledLookEvent >> sendTo: anObject [

	anObject unabledLookEvent: self
]
