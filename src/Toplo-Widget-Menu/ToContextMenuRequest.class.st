Class {
	#name : #ToContextMenuRequest,
	#superclass : #ToWindowOpenRequest,
	#category : 'Toplo-Widget-Menu-Context menu'
}

{ #category : #sending }
ToContextMenuRequest >> sendTo: anEvent [

	anEvent contextMenuRequest: self
]
