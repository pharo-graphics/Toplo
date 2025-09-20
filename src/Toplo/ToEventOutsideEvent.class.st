Class {
	#name : #ToEventOutsideEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent',
		'emitter'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToEventOutsideEvent >> emitter [

	^ emitter
]

{ #category : #accessing }
ToEventOutsideEvent >> emitter: anObject [

	emitter := anObject
]

{ #category : #accessing }
ToEventOutsideEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToEventOutsideEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
