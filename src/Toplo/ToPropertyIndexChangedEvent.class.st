Class {
	#name : #ToPropertyIndexChangedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-Properties'
}

{ #category : #sending }
ToPropertyIndexChangedEvent >> sendTo: anObject [

	anObject propertyIndexChangedEvent: self
]
