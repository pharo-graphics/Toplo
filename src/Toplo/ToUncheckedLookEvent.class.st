Class {
	#name : #ToUncheckedLookEvent,
	#superclass : #ToIntrasicStateLookEvent,
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToUncheckedLookEvent >> sendTo: anObject [

	anObject uncheckedLookEvent: self
]
