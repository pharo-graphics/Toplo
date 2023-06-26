Class {
	#name : #ToMenuBarMenuEvent,
	#superclass : #BlEvent,
	#instVars : [
		'menu'
	],
	#category : #'Toplo-Widget-MenuBar'
}

{ #category : #accessing }
ToMenuBarMenuEvent >> menu [

	^ menu
]

{ #category : #accessing }
ToMenuBarMenuEvent >> menu: aMenu [

	menu := aMenu
]
