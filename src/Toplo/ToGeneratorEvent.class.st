Class {
	#name : #ToGeneratorEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent',
		'sourceHandler'
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

{ #category : #accessing }
ToGeneratorEvent >> sourceHandler [

	^ sourceHandler
]

{ #category : #accessing }
ToGeneratorEvent >> sourceHandler: anObject [

	sourceHandler := anObject
]
