Class {
	#name : #ToAddedToSpaceEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToAddedToSpaceEvent >> sendTo: anObject [

	anObject addedToSpaceEvent: self
]
