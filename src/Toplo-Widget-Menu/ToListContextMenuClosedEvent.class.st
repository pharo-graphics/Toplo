Class {
	#name : #ToListContextMenuClosedEvent,
	#superclass : #ToContextMenuClosedEvent,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #sending }
ToListContextMenuClosedEvent >> sendTo: anEvent [

	anEvent listContextMenuClosedEvent: self
]
