Class {
	#name : #ToMouseMoveOutsideEvent,
	#superclass : #ToOutsideEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToMouseMoveOutsideEvent >> sendTo: anObject [

	anObject mouseMoveOutsideEvent: self
]
