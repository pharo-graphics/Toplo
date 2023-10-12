Class {
	#name : #ToOpenedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToOpenedLookEvent >> sendTo: anObject [

	anObject openedLookEvent: self
]
