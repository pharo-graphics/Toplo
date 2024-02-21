Class {
	#name : #ToListSelectionModeChangedEvent,
	#superclass : #ToListElementEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListSelectionModeChangedEvent >> sendTo: anObject [

	anObject listSelectionModeChangedEvent: self
]
