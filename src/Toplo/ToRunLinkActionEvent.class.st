Class {
	#name : #ToRunLinkActionEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #accessing }
ToRunLinkActionEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToRunLinkActionEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
