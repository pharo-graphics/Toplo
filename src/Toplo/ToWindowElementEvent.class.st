Class {
	#name : #ToWindowElementEvent,
	#superclass : #BlEvent,
	#instVars : [
		'window'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToWindowElementEvent >> window [

	^ window
]

{ #category : #accessing }
ToWindowElementEvent >> window: aWindow [

	window := aWindow
]
