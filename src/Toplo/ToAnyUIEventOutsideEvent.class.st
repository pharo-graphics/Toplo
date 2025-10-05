Class {
	#name : #ToAnyUIEventOutsideEvent,
	#superclass : #ToOutsideEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToAnyUIEventOutsideEvent >> sendTo: anObject [

	anObject anyUIEventOutsideEvent: self
]
