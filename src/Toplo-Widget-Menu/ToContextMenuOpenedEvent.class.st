Class {
	#name : #ToContextMenuOpenedEvent,
	#superclass : #ToAnchoredWindowOpenedEvent,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #sending }
ToContextMenuOpenedEvent >> sendTo: anObject [

	anObject contextMenuOpenedEvent: self
]
