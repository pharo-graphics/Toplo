Class {
	#name : #ToSelectGroupSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #sending }
ToSelectGroupSelectionChangedEvent >> sendTo: anObject [

	anObject selectGroupSelectionChangedEvent: self
]
