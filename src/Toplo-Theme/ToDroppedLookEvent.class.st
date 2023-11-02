Class {
	#name : 'ToDroppedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToDroppedLookEvent >> sendTo: anObject [

	anObject droppedLookEvent: self
]
