Class {
	#name : #ToActionRunnedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent',
		'actionLink'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #accessing }
ToActionRunnedEvent >> actionLink [

	^ actionLink
]

{ #category : #accessing }
ToActionRunnedEvent >> actionLink: anObject [

	actionLink := anObject
]

{ #category : #sending }
ToActionRunnedEvent >> sendTo: anObject [

	anObject actionRunnedEvent: self
]

{ #category : #accessing }
ToActionRunnedEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToActionRunnedEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
