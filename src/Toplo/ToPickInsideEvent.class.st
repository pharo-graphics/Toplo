Class {
	#name : #ToPickInsideEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToPickInsideEvent >> sendTo: anObject [

	anObject pickInsideEvent: self
]
