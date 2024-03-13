Class {
	#name : #ToListPrimarySelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListPrimarySelectionChangedEvent >> sendTo: anObject [

	anObject listPrimarySelectionChangedEvent: self
]
