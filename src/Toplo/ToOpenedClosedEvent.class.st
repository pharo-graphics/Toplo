Class {
	#name : #ToOpenedClosedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'window'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToOpenedClosedEvent >> window [

	^ window
]

{ #category : #accessing }
ToOpenedClosedEvent >> window: anObject [

	window := anObject
]
