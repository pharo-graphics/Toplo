Class {
	#name : #ToLinkActionRunnedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #sending }
ToLinkActionRunnedEvent >> sendTo: anObject [

	anObject linkActionRunnedEvent: self
]

{ #category : #accessing }
ToLinkActionRunnedEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToLinkActionRunnedEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
