Class {
	#name : #ToContextMenuClosedEvent,
	#superclass : #ToContextMenuEvent,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #sending }
ToContextMenuClosedEvent >> sendTo: anEvent [

	anEvent contextMenuClosedEvent: self
]
