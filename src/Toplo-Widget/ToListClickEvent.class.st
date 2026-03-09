Class {
	#name : #ToListClickEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListClickEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToListClickEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
