Class {
	#name : #ToSelectionModelCommandAddedEvent,
	#superclass : #ToSelectionModelCommandEvent,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #sending }
ToSelectionModelCommandAddedEvent >> sendTo: anObject [

	anObject selectionModelCommandAddedEvent: self
]
