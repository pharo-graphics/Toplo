Class {
	#name : #ToListShiftSelectionEvent,
	#superclass : #ToListIndexGroupEvent,
	#category : #'Toplo-Widget-List-Selection-Deprecated'
}

{ #category : #testing }
ToListShiftSelectionEvent class >> isDeprecated [

	^ true
]

{ #category : #sending }
ToListShiftSelectionEvent >> sendTo: anObject [

	anObject listShiftSelectionEvent: self
]
