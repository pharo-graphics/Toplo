Class {
	#name : #ToContextMenuClosedEvent,
	#superclass : #ToWindowClosedEvent,
	#category : 'Toplo-Widget-Menu-Context Menu'
}

{ #category : #sending }
ToContextMenuClosedEvent >> sendTo: anEvent [

	anEvent contextMenuClosedEvent: self
]
