Class {
	#name : #ToListSelectionDirtyEvent,
	#superclass : #ToListSelectionEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListSelectionDirtyEvent >> sendTo: anObject [

	anObject listSelectionDirtyEvent: self
]
