Class {
	#name : #ToListUnselectableSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListUnselectableSelectionChangedEvent >> sendTo: anObject [

	anObject listUnselectableSelectionChangedEvent: self
]
