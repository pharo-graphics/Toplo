Class {
	#name : #ToPickOutsideEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToPickOutsideEvent >> sendTo: anObject [

	anObject pickOutsideEvent: self
]
