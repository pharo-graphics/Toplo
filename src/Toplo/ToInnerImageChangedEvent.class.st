Class {
	#name : #ToInnerImageChangedEvent,
	#superclass : #ToElementPropertyChangedEvent,
	#category : #'Toplo-Widget-Image'
}

{ #category : #sending }
ToInnerImageChangedEvent >> sendTo: anObject [

	anObject innerImageChanged: self
]
