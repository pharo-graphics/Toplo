Class {
	#name : #ToContextMenuClosedEvent,
	#superclass : #ToWindowClosedEvent,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #sending }
ToContextMenuClosedEvent >> sendTo: anEvent [

	anEvent contextMenuClosedEvent: self
]
