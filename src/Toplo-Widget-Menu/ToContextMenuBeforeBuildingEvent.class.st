Class {
	#name : 'ToContextMenuBeforeBuildingEvent',
	#superclass : 'ToWindowBeforeBuildingEvent',
	#category : 'Toplo-Widget-Menu-Context Menu',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Context Menu'
}

{ #category : 'sending' }
ToContextMenuBeforeBuildingEvent >> sendTo: anEvent [

	anEvent contextMenuBeforeBuildingEvent: self
]
