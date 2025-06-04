Class {
	#name : #ToSievePatternChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sieve'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #sending }
ToSievePatternChangedEvent >> sendTo: anObject [

	anObject sievePatternChangedEvent: self
]

{ #category : #accessing }
ToSievePatternChangedEvent >> sieve [

	^ sieve
]

{ #category : #accessing }
ToSievePatternChangedEvent >> sieve: aSieve [

	sieve := aSieve
]
