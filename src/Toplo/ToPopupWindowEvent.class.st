Class {
	#name : #ToPopupWindowEvent,
	#superclass : #BlEvent,
	#instVars : [
		'window'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToPopupWindowEvent >> window [

	^ window
]

{ #category : #accessing }
ToPopupWindowEvent >> window: aWindow [

	window := aWindow
]
