Class {
	#name : #ToWidgetWindowEvent,
	#superclass : #BlEvent,
	#instVars : [
		'window'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToWidgetWindowEvent >> window [

	^ window
]

{ #category : #accessing }
ToWidgetWindowEvent >> window: aWindow [

	window := aWindow
]
