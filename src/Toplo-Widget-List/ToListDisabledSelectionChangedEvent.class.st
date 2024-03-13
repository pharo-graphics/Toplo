Class {
	#name : #ToListDisabledSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListDisabledSelectionChangedEvent >> sendTo: anObject [

	anObject listDisabledSelectionChangedEvent: self
]
