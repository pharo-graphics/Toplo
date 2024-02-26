Class {
	#name : #ToListSecondarySelectionModeChangedEvent,
	#superclass : #ToListElementEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListSecondarySelectionModeChangedEvent >> sendTo: anObject [

	anObject listSecondarySelectionModeChangedEvent: self
]
