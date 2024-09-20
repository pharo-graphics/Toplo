Class {
	#name : #ToWindowEvent,
	#superclass : #BlEvent,
	#instVars : [
		'windowManager'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToWindowEvent >> windowManager [

	^ windowManager
]

{ #category : #accessing }
ToWindowEvent >> windowManager: anAnchoredWindowManager [

	windowManager := anAnchoredWindowManager
]
