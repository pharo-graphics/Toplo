Class {
	#name : #ToMenuBarMenuEvent,
	#superclass : #BlEvent,
	#instVars : [
		'menu'
	],
	#category : 'Toplo-Widget-Menu-Bar'
}

{ #category : #accessing }
ToMenuBarMenuEvent >> menu [

	^ menu
]

{ #category : #accessing }
ToMenuBarMenuEvent >> menu: aMenu [

	menu := aMenu
]
