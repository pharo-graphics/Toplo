Class {
	#name : #ToListPrimarySelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListPrimarySelectionChangedEvent >> sendTo: anObject [

	anObject listPrimarySelectionChangedEvent: self
]
