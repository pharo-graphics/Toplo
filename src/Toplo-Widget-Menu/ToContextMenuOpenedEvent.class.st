Class {
	#name : #ToContextMenuOpenedEvent,
	#superclass : #ToWindowOpenedEvent,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #sending }
ToContextMenuOpenedEvent >> sendTo: anObject [

	anObject contextMenuOpenedEvent: self
]
