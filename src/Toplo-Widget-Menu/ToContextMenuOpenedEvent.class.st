Class {
	#name : 'ToContextMenuOpenedEvent',
	#superclass : 'ToWindowOpenedEvent',
	#category : 'Toplo-Widget-Menu-Context menu',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Context menu'
}

{ #category : 'sending' }
ToContextMenuOpenedEvent >> sendTo: anEvent [

	anEvent contextMenuOpenedEvent: self
]
