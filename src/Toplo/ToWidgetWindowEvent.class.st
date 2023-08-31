Class {
	#name : #ToWidgetWindowEvent,
	#superclass : #BlEvent,
	#instVars : [
		'window'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToWidgetWindowEvent >> window [

	^ window
]

{ #category : #accessing }
ToWidgetWindowEvent >> window: aWindow [

	window := aWindow
]
