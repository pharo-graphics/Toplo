Class {
	#name : #ToListClickEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListClickEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToListClickEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
