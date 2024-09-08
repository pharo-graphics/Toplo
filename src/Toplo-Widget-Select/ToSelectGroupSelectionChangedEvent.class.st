Class {
	#name : #ToSelectGroupSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #sending }
ToSelectGroupSelectionChangedEvent >> sendTo: anObject [

	anObject selectGroupSelectionChangedEvent: self
]
