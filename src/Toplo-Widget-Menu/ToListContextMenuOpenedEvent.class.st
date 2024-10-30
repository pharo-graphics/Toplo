Class {
	#name : #ToListContextMenuOpenedEvent,
	#superclass : #ToContextMenuOpenedEvent,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #sending }
ToListContextMenuOpenedEvent >> sendTo: anObject [

	anObject listContextMenuOpenedEvent: self
]
