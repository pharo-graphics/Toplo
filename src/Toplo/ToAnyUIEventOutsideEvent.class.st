Class {
	#name : #ToAnyUIEventOutsideEvent,
	#superclass : #ToEventOutsideEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToAnyUIEventOutsideEvent >> sendTo: anObject [

	anObject anyUIEventOutsideEvent: self
]
