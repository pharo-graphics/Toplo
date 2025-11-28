Class {
	#name : #ToDividerRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Pane-Events'
}

{ #category : #accessing }
ToDividerRequestEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToDividerRequestEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
