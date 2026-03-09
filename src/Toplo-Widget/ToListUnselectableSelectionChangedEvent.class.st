Class {
	#name : #ToListUnselectableSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListUnselectableSelectionChangedEvent >> sendTo: anObject [

	anObject listUnselectableSelectionChangedEvent: self
]
