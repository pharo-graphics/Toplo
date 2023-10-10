Class {
	#name : #ToContextMenuBeforeBuildingEvent,
	#superclass : #ToWindowBeforeBuildingEvent,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #sending }
ToContextMenuBeforeBuildingEvent >> sendTo: anEvent [

	anEvent contextMenuBeforeBuildingEvent: self
]
