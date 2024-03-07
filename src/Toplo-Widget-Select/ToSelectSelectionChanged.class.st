Class {
	#name : #ToSelectSelectionChanged,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #sending }
ToSelectSelectionChanged >> sendTo: anObject [

	anObject selectSelectionChanged: self
]
