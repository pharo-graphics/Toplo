Class {
	#name : #ToMouseUpOutsideEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent',
		'emitter'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToMouseUpOutsideEvent >> emitter [

	^ emitter
]

{ #category : #accessing }
ToMouseUpOutsideEvent >> emitter: anObject [

	emitter := anObject
]

{ #category : #sending }
ToMouseUpOutsideEvent >> sendTo: anObject [

	anObject mouseUpOutsideEvent: self
]

{ #category : #accessing }
ToMouseUpOutsideEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToMouseUpOutsideEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
