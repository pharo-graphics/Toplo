Class {
	#name : #ToEnabledLookEvent,
	#superclass : #ToIntrasicStateLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToEnabledLookEvent >> sendTo: anObject [

	anObject enabledLookEvent: self
]
