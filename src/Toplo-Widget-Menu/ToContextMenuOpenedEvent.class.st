Class {
	#name : #ToContextMenuOpenedEvent,
	#superclass : #ToWindowOpenedEvent,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #sending }
ToContextMenuOpenedEvent >> sendTo: anEvent [

	anEvent contextMenuOpenedEvent: self
]
