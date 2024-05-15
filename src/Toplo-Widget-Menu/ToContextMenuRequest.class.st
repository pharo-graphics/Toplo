Class {
	#name : #ToContextMenuRequest,
	#superclass : #ToAnchoredWindowOpenRequest,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #sending }
ToContextMenuRequest >> sendTo: anEvent [

	anEvent contextMenuRequest: self
]
