Class {
	#name : #ToInnerImageChangedEvent,
	#superclass : #ToPropertyChangedEvent,
	#category : #'Toplo-Widget-Image'
}

{ #category : #sending }
ToInnerImageChangedEvent >> sendTo: anObject [

	anObject innerImageChanged: self
]
