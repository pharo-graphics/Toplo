Class {
	#name : #ToListSelectionDirtyEvent,
	#superclass : #ToListElementEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListSelectionDirtyEvent >> sendTo: anObject [

	anObject listSelectionDirtyEvent: self
]
