Class {
	#name : 'ToContextMenuRequest',
	#superclass : 'ToWindowRequest',
	#category : 'Toplo-Widget-Menu-Context menu',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Context menu'
}

{ #category : 'sending' }
ToContextMenuRequest >> sendTo: anEvent [

	anEvent contextMenuRequest: self
]
