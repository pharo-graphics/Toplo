Class {
	#name : #ToContextMenuClosedEvent,
	#superclass : #ToContextMenuEvent,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #sending }
ToContextMenuClosedEvent >> sendTo: anEvent [

	anEvent contextMenuClosedEvent: self
]
