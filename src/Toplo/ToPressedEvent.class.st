Class {
	#name : #ToPressedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'modifiers'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #initialization }
ToPressedEvent >> initialize [ 

	super initialize.
	modifiers := BlKeyModifiers new
]

{ #category : #accessing }
ToPressedEvent >> modifiers [

	^ modifiers
]

{ #category : #accessing }
ToPressedEvent >> modifiers: anObject [

	modifiers := anObject
]
