Class {
	#name : #ToGeneratorEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #accessing }
ToGeneratorEvent >> modifiers [

	^ sourceEvent modifiers
]

{ #category : #accessing }
ToGeneratorEvent >> position [

	^ sourceEvent position
]

{ #category : #accessing }
ToGeneratorEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToGeneratorEvent >> sourceEvent: anObject [

	sourceEvent := anObject
]
