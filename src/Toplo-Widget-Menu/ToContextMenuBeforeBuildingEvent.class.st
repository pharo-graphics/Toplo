Class {
	#name : #ToContextMenuBeforeBuildingEvent,
	#superclass : #ToWindowBeforeBuildingEvent,
	#category : 'Toplo-Widget-Menu-Context Menu'
}

{ #category : #sending }
ToContextMenuBeforeBuildingEvent >> sendTo: anEvent [

	anEvent contextMenuBeforeBuildingEvent: self
]
