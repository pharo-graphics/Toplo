Class {
	#name : #ToListClickOnNodeEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListClickOnNodeEvent >> sendTo: anObject [

	anObject listClickOnNodeEvent: self

	
]

{ #category : #accessing }
ToListClickOnNodeEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToListClickOnNodeEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
