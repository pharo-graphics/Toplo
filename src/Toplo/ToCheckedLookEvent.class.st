Class {
	#name : #ToCheckedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToCheckedLookEvent >> sendTo: anObject [

	anObject checkedLookEvent: self
]
