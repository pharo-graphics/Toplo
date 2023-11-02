Class {
	#name : 'ToFocusedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToFocusedLookEvent >> sendTo: anObject [

	anObject focusedLookEvent: self
]
