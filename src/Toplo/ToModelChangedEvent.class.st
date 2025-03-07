Class {
	#name : #ToModelChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'model',
		'event'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #accessing }
ToModelChangedEvent >> event [

	^ event
]

{ #category : #accessing }
ToModelChangedEvent >> event: anEvent [

	event := anEvent
]

{ #category : #accessing }
ToModelChangedEvent >> model [

	^ model
]

{ #category : #accessing }
ToModelChangedEvent >> model: anObject [

	model := anObject
]
