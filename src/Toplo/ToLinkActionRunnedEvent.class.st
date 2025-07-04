Class {
	#name : #ToLinkActionRunnedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'linkedObject',
		'sourceEvent',
		'changedValue'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #accessing }
ToLinkActionRunnedEvent >> changedValue [

	^ changedValue
]

{ #category : #accessing }
ToLinkActionRunnedEvent >> changedValue: anObject [

	changedValue := anObject
]

{ #category : #accessing }
ToLinkActionRunnedEvent >> linkedObject [

	^ linkedObject
]

{ #category : #accessing }
ToLinkActionRunnedEvent >> linkedObject: anObject [

	linkedObject := anObject
]

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
