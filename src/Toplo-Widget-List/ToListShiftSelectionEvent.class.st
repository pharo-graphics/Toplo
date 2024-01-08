Class {
	#name : #ToListShiftSelectionEvent,
	#superclass : #ToListIndexGroupEvent,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #sending }
ToListShiftSelectionEvent >> sendTo: anObject [

	anObject listShiftSelectionEvent: self
]
