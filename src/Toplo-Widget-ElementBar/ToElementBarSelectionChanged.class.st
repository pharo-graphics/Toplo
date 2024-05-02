Class {
	#name : #ToElementBarSelectionChanged,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #sending }
ToElementBarSelectionChanged >> sendTo: anObject [

	anObject elementBarSelectionChanged: self
]
