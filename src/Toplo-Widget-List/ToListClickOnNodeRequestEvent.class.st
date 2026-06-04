Class {
	#name : #ToListClickOnNodeRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListClickOnNodeRequestEvent >> sendTo: anObject [

	anObject listClickOnNodeRequestEvent: self
]

{ #category : #accessing }
ToListClickOnNodeRequestEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToListClickOnNodeRequestEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
