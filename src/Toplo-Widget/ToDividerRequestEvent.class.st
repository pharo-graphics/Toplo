Class {
	#name : #ToDividerRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #accessing }
ToDividerRequestEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToDividerRequestEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
