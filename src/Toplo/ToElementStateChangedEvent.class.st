Class {
	#name : #ToElementStateChangedEvent,
	#superclass : #ToElementLookEvent,
	#instVars : [
		'state'
	],
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToElementStateChangedEvent >> sendToLook: aLook [

	self state sendEvent: self toLook: aLook
]

{ #category : #accessing }
ToElementStateChangedEvent >> state [

	^ state
]

{ #category : #accessing }
ToElementStateChangedEvent >> state: anElementState [

	state := anElementState
]
