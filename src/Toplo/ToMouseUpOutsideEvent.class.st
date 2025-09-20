Class {
	#name : #ToMouseUpOutsideEvent,
	#superclass : #ToEventOutsideEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToMouseUpOutsideEvent >> sendTo: anObject [

	anObject mouseUpOutsideEvent: self
]
