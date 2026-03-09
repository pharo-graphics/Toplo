Class {
	#name : #ToSievePatternChangedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToSievePatternChangedEvent >> sendTo: anObject [

	anObject sievePatternChangedEvent: self
]
