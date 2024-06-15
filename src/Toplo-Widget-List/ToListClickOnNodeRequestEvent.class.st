Class {
	#name : #ToListClickOnNodeRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListClickOnNodeRequestEvent >> sendTo: anObject [

	anObject listClickOnNodeRequestEvent: self
]
