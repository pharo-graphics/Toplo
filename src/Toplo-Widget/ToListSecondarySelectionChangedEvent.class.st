Class {
	#name : #ToListSecondarySelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListSecondarySelectionChangedEvent >> sendTo: anObject [

	anObject listSecondarySelectionChangedEvent: self
]
