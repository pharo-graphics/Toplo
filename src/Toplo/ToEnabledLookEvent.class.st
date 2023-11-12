Class {
	#name : #ToEnabledLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToEnabledLookEvent >> sendTo: anObject [

	anObject enabledLookEvent: self
]
