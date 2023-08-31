Class {
	#name : #ToContextMenuOpenedEvent,
	#superclass : #ToContextMenuEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #accessing }
ToContextMenuOpenedEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToContextMenuOpenedEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
