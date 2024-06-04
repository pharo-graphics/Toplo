Class {
	#name : #ToContextMenuClosedEvent,
	#superclass : #ToAnchoredWindowClosedEvent,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #sending }
ToContextMenuClosedEvent >> sendTo: anEvent [

	anEvent contextMenuClosedEvent: self
]
