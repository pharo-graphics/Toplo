Class {
	#name : #ToListPrimarySelectionModeChangedEvent,
	#superclass : #ToListElementEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListPrimarySelectionModeChangedEvent >> sendTo: anObject [

	anObject listPrimarySelectionModeChangedEvent: self
]
