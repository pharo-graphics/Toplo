Class {
	#name : #ToWidgetWindowOpenedEvent,
	#superclass : #ToWidgetWindowEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToWidgetWindowOpenedEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToWidgetWindowOpenedEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
