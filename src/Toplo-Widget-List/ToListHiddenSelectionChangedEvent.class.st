Class {
	#name : #ToListHiddenSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListHiddenSelectionChangedEvent >> sendTo: anObject [

	anObject listHiddenSelectionChangedEvent: self
]
