Class {
	#name : #ToWindowBeforeBuildingEvent,
	#superclass : #ToWindowOpeningEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToWindowBeforeBuildingEvent >> sendTo: anObject [

	anObject windowBeforeBuildingEvent: self
]
