Class {
	#name : 'ToContextMenuOpenedEvent',
	#superclass : 'ToWindowOpenedEvent',
	#category : 'Toplo-Widget-Menu-Context Menu',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Context Menu'
}

{ #category : 'sending' }
ToContextMenuOpenedEvent >> sendTo: anEvent [

	anEvent contextMenuOpenedEvent: self
]
