Class {
	#name : #ToInnerImageChangedEvent,
	#superclass : #ToElementPropertyChanged,
	#category : #'Toplo-Widget-Image'
}

{ #category : #sending }
ToInnerImageChangedEvent >> sendTo: anObject [

	anObject innerImageChanged: self
]
