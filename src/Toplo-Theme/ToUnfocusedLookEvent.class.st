Class {
	#name : 'ToUnfocusedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToUnfocusedLookEvent >> sendTo: anObject [

	anObject unfocusedLookEvent: self
]
