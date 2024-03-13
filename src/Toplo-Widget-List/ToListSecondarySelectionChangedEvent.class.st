Class {
	#name : #ToListSecondarySelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListSecondarySelectionChangedEvent >> sendTo: anObject [

	anObject listSecondarySelectionChangedEvent: self
]
