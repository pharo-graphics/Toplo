Class {
	#name : #ToUncheckedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToUncheckedLookEvent >> sendTo: anObject [

	anObject uncheckedLookEvent: self
]
