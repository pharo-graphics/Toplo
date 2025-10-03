Class {
	#name : #ToMouseOutsideEvent,
	#superclass : #ToOutsideEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToMouseOutsideEvent >> sendTo: anObject [

	anObject mouseOutsideEvent: self
]
