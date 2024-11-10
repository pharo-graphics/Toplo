Class {
	#name : #ToHoveredEvent,
	#superclass : #BlEvent,
	#instVars : [
		'modifiers'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #initialization }
ToHoveredEvent >> initialize [ 

	super initialize.
	modifiers := BlKeyModifiers new
]

{ #category : #accessing }
ToHoveredEvent >> modifiers [

	^ modifiers
]

{ #category : #accessing }
ToHoveredEvent >> modifiers: anObject [

	modifiers := anObject
]
