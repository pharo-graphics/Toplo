Class {
	#name : #ToMouseUpOutsideEvent,
	#superclass : #ToOutsideEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToMouseUpOutsideEvent >> sendTo: anObject [

	anObject mouseUpOutsideEvent: self
]
