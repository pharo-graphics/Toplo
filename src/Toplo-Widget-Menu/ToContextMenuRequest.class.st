Class {
	#name : #ToContextMenuRequest,
	#superclass : #ToAnchoredWindowRequest,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #sending }
ToContextMenuRequest >> sendTo: anEvent [

	anEvent contextMenuRequest: self
]
