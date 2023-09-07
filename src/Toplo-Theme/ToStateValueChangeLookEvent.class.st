Class {
	#name : #ToStateValueChangeLookEvent,
	#superclass : #ToElementLookEvent,
	#instVars : [
		'stateValue'
	],
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToStateValueChangeLookEvent >> sendToLook: aLook [

	aLook stateValueChangeLookEvent: self
]

{ #category : #accessing }
ToStateValueChangeLookEvent >> stateValue [

	^ stateValue
]

{ #category : #accessing }
ToStateValueChangeLookEvent >> stateValue: aStateValue [

	stateValue := aStateValue
]
