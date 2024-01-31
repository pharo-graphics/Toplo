Class {
	#name : #ToListSelectionModeChangedEvent,
	#superclass : #ToListSelectionEvent,
	#category : #'Toplo-Widget-List-Selection-Strategy'
}

{ #category : #sending }
ToListSelectionModeChangedEvent >> sendTo: anObject [

	anObject listSelectionModeChangedEvent: self
]
