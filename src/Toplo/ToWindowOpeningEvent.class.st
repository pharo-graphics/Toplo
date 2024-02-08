Class {
	#name : #ToWindowOpeningEvent,
	#superclass : #ToWindowElementEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'as yet unclassified' }
ToWindowOpeningEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #'as yet unclassified' }
ToWindowOpeningEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
