Class {
	#name : #ToListSelectionDirtyEvent,
	#superclass : #ToListSelectionEvent,
	#category : #'Toplo-Widget-List-Selection-Strategy'
}

{ #category : #sending }
ToListSelectionDirtyEvent >> sendTo: anObject [

	anObject listSelectionDirtyEvent: self
]
