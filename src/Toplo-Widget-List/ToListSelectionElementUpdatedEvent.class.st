Class {
	#name : #ToListSelectionElementUpdatedEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Widget-List-Selection'
}

{ #category : #sending }
ToListSelectionElementUpdatedEvent >> sendTo: anObject [

	anObject listSelectionElementUpdatedEvent: self
]
