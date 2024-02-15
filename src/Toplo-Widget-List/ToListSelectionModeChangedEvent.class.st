Class {
	#name : #ToListSelectionModeChangedEvent,
	#superclass : #ToListSelectionEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListSelectionModeChangedEvent >> sendTo: anObject [

	anObject listSelectionModeChangedEvent: self
]
