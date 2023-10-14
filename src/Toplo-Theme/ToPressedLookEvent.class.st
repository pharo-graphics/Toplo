Class {
	#name : 'ToPressedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToPressedLookEvent >> sendTo: anObject [

	anObject pressedLookEvent: self
]
