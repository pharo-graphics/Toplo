Class {
	#name : 'ToContextMenuOpenedEvent',
	#superclass : 'ToWindowOpenedEvent',
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'sending' }
ToContextMenuOpenedEvent >> sendTo: anEvent [

	anEvent contextMenuOpenedEvent: self
]
