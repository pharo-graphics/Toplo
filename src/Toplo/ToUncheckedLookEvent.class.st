Class {
	#name : #ToUncheckedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToUncheckedLookEvent >> sendTo: anObject [

	anObject uncheckedLookEvent: self
]
