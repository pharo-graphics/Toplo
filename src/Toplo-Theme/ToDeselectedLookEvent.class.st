Class {
	#name : 'ToDeselectedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToDeselectedLookEvent >> sendTo: anObject [

	anObject deselectedLookEvent: self
]
