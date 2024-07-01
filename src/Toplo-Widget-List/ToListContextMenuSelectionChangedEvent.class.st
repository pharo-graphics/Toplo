Class {
	#name : #ToListContextMenuSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListContextMenuSelectionChangedEvent >> sendTo: anObject [

	anObject listContextMenuSelectionChangedEvent: self
]
