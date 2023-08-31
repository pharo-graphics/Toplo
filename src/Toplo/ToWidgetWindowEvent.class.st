Class {
	#name : #ToWidgetWindowEvent,
	#superclass : #BlEvent,
	#instVars : [
		'window'
	],
	#category : #'Toplo-window'
}

{ #category : #accessing }
ToWidgetWindowEvent >> window [

	^ window
]

{ #category : #accessing }
ToWidgetWindowEvent >> window: aWindow [

	window := aWindow
]
