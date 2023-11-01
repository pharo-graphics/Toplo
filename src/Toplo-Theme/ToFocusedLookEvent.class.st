Class {
	#name : #ToFocusedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToFocusedLookEvent >> sendTo: anObject [

	anObject focusedLookEvent: self
]
