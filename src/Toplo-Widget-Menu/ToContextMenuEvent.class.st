Class {
	#name : #ToContextMenuEvent,
	#superclass : #BlEvent,
	#instVars : [
		'widget'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #accessing }
ToContextMenuEvent >> widget [

	^ widget
]

{ #category : #accessing }
ToContextMenuEvent >> widget: aWidget [

	widget := aWidget
]
