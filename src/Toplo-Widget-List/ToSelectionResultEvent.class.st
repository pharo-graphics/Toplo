Class {
	#name : #ToSelectionResultEvent,
	#superclass : #ToSelectionCommandEvent,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #sending }
ToSelectionResultEvent >> sendTo: anObject [

	anObject selectionResultEvent: self
]
