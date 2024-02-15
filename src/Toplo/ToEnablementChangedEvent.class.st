Class {
	#name : #ToEnablementChangedEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Core'
}

{ #category : #sending }
ToEnablementChangedEvent >> sendTo: anObject [

	anObject enablementChangedEvent: self
]
