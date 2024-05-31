Class {
	#name : #ToPreNotificationEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core'
}

{ #category : #visiting }
ToPreNotificationEvent >> accept [
]

{ #category : #visiting }
ToPreNotificationEvent >> accepted [

	^ sourceEvent notNil
]

{ #category : #visiting }
ToPreNotificationEvent >> deny [

	sourceEvent := nil
]

{ #category : #accessing }
ToPreNotificationEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToPreNotificationEvent >> sourceEvent: aSelectionChangedEvent [

	sourceEvent := aSelectionChangedEvent
]
