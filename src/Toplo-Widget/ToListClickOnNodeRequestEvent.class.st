Class {
	#name : #ToListClickOnNodeRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListClickOnNodeRequestEvent >> sendTo: anObject [

	anObject listClickOnNodeRequestEvent: self
]
