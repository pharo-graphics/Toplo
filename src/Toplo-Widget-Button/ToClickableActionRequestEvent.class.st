Class {
	#name : #ToClickableActionRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #sending }
ToClickableActionRequestEvent >> sendTo: anObject [

	anObject clickableActionRequestEvent: self
]
