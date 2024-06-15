Class {
	#name : #ToListPrimarySelectionChangeRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListPrimarySelectionChangeRequestEvent >> sendTo: anObject [

	anObject listPrimarySelectionChangeRequestEvent: self
]
