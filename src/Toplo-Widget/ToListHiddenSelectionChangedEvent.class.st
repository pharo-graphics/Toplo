Class {
	#name : #ToListHiddenSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListHiddenSelectionChangedEvent >> sendTo: anObject [

	anObject listHiddenSelectionChangedEvent: self
]
