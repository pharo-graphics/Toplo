Class {
	#name : 'ToClickedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToClickedLookEvent >> sendTo: anObject [

	anObject clickedLookEvent: self
]
