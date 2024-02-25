Class {
	#name : #ToSelectListSelectionChanged,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #sending }
ToSelectListSelectionChanged >> sendTo: anObject [

	anObject selectListSelectionChanged: self
]
