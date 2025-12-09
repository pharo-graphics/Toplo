Class {
	#name : #ToSelectGroupSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #sending }
ToSelectGroupSelectionChangedEvent >> sendTo: anObject [

	anObject selectGroupSelectionChangedEvent: self
]
