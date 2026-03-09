Class {
	#name : #ToListContextMenuSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListContextMenuSelectionChangedEvent >> sendTo: anObject [

	anObject listContextMenuSelectionChangedEvent: self
]
