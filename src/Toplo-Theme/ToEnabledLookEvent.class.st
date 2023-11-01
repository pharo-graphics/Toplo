Class {
	#name : #ToEnabledLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToEnabledLookEvent >> sendTo: anObject [

	anObject enabledLookEvent: self
]
