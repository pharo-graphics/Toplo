Class {
	#name : #ToContextMenuOpenedEvent,
	#superclass : #ToContextMenuEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #sending }
ToContextMenuOpenedEvent >> sendTo: anEvent [

	anEvent contextMenuOpenedEvent: self
]

{ #category : #accessing }
ToContextMenuOpenedEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToContextMenuOpenedEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
