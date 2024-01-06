Class {
	#name : #ToContextMenuClosedEvent,
	#superclass : #ToWindowClosedEvent,
	#category : 'Toplo-Widget-Menu-Context menu'
}

{ #category : #sending }
ToContextMenuClosedEvent >> sendTo: anEvent [

	anEvent contextMenuClosedEvent: self
]
