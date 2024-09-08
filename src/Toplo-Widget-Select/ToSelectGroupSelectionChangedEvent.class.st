Class {
	#name : #ToSelectGroupSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #sending }
ToSelectGroupSelectionChangedEvent >> sendTo: anObject [

	anObject selectGroupSelectionChangedEvent: self
]
