Class {
	#name : #ToSelectionCommandAddedEvent,
	#superclass : #ToSelectionCommandEvent,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #sending }
ToSelectionCommandAddedEvent >> sendTo: anObject [

	anObject selectionCommandAddedEvent: self
]
