Class {
	#name : #ToWindowOpeningEvent,
	#superclass : #ToWindowElementEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : 'Toplo-Core-Window'
}

{ #category : #accessing }
ToWindowOpeningEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToWindowOpeningEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
