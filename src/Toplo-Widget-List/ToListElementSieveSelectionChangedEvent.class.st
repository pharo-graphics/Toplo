Class {
	#name : #ToListElementSieveSelectionChangedEvent,
	#superclass : #ToListElementSieveEvent,
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #sending }
ToListElementSieveSelectionChangedEvent >> sendTo: anObject [

	anObject listElementSieveSelectionChangedEvent: self
]
