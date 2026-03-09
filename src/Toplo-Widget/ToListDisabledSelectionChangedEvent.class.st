Class {
	#name : #ToListDisabledSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListDisabledSelectionChangedEvent >> sendTo: anObject [

	anObject listDisabledSelectionChangedEvent: self
]
