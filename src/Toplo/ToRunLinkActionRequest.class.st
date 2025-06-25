Class {
	#name : #ToRunLinkActionRequest,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #accessing }
ToRunLinkActionRequest >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToRunLinkActionRequest >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
