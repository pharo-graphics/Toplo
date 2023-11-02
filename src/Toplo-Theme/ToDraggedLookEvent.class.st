Class {
	#name : 'ToDraggedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToDraggedLookEvent >> sendTo: anObject [

	anObject draggedLookEvent: self
]
