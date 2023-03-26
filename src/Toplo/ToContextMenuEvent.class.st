Class {
	#name : #ToContextMenuEvent,
	#superclass : #BlEvent,
	#instVars : [
		'widget'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToContextMenuEvent >> widget [

	^ widget
]

{ #category : #accessing }
ToContextMenuEvent >> widget: aWidget [

	widget := aWidget
]
