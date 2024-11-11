Class {
	#name : #ToGeneratorEvent,
	#superclass : #BlEvent,
	#instVars : [
		'modifiers'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #initialization }
ToGeneratorEvent >> initialize [ 

	super initialize.
	modifiers := BlKeyModifiers new
]

{ #category : #accessing }
ToGeneratorEvent >> modifiers [

	^ modifiers
]

{ #category : #accessing }
ToGeneratorEvent >> modifiers: anObject [

	modifiers := anObject
]
