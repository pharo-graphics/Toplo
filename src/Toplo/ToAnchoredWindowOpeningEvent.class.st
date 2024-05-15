Class {
	#name : #ToAnchoredWindowOpeningEvent,
	#superclass : #ToAnchoredWindowEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'as yet unclassified' }
ToAnchoredWindowOpeningEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #'as yet unclassified' }
ToAnchoredWindowOpeningEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
