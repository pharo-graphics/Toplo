Class {
	#name : 'ToContextMenuRequest',
	#superclass : 'ToWindowRequest',
	#category : 'Toplo-Widget-Menu-Context Menu',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Context Menu'
}

{ #category : 'sending' }
ToContextMenuRequest >> sendTo: anEvent [

	anEvent contextMenuRequest: self
]
