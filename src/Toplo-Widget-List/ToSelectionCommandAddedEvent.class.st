Class {
	#name : #ToSelectionCommandAddedEvent,
	#superclass : #ToSelectionCommandEvent,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #sending }
ToSelectionCommandAddedEvent >> sendTo: anObject [

	anObject selectionCommandAddedEvent: self
]
