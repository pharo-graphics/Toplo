Class {
	#name : #ToListSelectionDirtyEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #sending }
ToListSelectionDirtyEvent >> sendTo: anObject [

	anObject listSelectionDirtyEvent: self
]
