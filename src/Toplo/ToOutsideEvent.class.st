Class {
	#name : #ToOutsideEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent',
		'emitter'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToOutsideEvent >> emitter [

	^ emitter
]

{ #category : #accessing }
ToOutsideEvent >> emitter: anObject [

	emitter := anObject
]

{ #category : #accessing }
ToOutsideEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToOutsideEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
