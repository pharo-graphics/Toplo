Class {
	#name : 'ToContextMenuBeforeBuildingEvent',
	#superclass : 'ToWindowBeforeBuildingEvent',
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'sending' }
ToContextMenuBeforeBuildingEvent >> sendTo: anEvent [

	anEvent contextMenuBeforeBuildingEvent: self
]
