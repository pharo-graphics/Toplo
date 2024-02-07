Class {
	#name : #ToSelectionResultEvent,
	#superclass : #ToSelectionModelCommandEvent,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #sending }
ToSelectionResultEvent >> sendTo: anObject [

	anObject selectionResultEvent: self
]
