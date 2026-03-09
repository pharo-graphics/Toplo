Class {
	#name : #ToSelectGroupSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-Select'
}

{ #category : #sending }
ToSelectGroupSelectionChangedEvent >> sendTo: anObject [

	anObject selectGroupSelectionChangedEvent: self
]
