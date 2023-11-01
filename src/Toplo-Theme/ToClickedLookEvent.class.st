Class {
	#name : #ToClickedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToClickedLookEvent >> sendTo: anObject [

	anObject clickedLookEvent: self
]
