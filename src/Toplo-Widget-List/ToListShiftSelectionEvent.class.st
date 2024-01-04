Class {
	#name : #ToListShiftSelectionEvent,
	#superclass : #ToListIndexGroupEvent,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #sending }
ToListShiftSelectionEvent >> sendTo: anObject [

	anObject listShiftSelectionEvent: self
]
