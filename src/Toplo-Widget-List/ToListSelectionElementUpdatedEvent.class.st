Class {
	#name : #ToListSelectionElementUpdatedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #sending }
ToListSelectionElementUpdatedEvent >> sendTo: anObject [

	anObject listSelectionElementUpdatedEvent: self
]
