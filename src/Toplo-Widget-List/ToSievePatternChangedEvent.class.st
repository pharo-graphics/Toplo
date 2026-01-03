Class {
	#name : #ToSievePatternChangedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #sending }
ToSievePatternChangedEvent >> sendTo: anObject [

	anObject sievePatternChangedEvent: self
]
