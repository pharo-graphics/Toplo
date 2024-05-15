Class {
	#name : #ToAnchoredWindowEvent,
	#superclass : #BlEvent,
	#instVars : [
		'windowManager'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindowEvent >> windowManager [

	^ windowManager
]

{ #category : #accessing }
ToAnchoredWindowEvent >> windowManager: anAnchoredWindowManager [

	windowManager := anAnchoredWindowManager
]
