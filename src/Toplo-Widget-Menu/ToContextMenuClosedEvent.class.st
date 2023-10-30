Class {
	#name : 'ToContextMenuClosedEvent',
	#superclass : 'ToWindowClosedEvent',
	#category : 'Toplo-Widget-Menu-Context Menu',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Context Menu'
}

{ #category : 'sending' }
ToContextMenuClosedEvent >> sendTo: anEvent [

	anEvent contextMenuClosedEvent: self
]
