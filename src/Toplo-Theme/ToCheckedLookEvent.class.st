Class {
	#name : #ToCheckedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToCheckedLookEvent >> sendTo: anObject [

	anObject checkedLookEvent: self
]
