Class {
	#name : #ToCheckedLookEvent,
	#superclass : #ToIntrasicStateLookEvent,
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToCheckedLookEvent >> sendTo: anObject [

	anObject checkedLookEvent: self
]
