Class {
	#name : #ToContextMenuOpenedEvent,
	#superclass : #ToWindowOpenedEvent,
	#category : 'Toplo-Widget-Menu-Context Menu'
}

{ #category : #sending }
ToContextMenuOpenedEvent >> sendTo: anEvent [

	anEvent contextMenuOpenedEvent: self
]
