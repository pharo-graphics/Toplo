Class {
	#name : #ToSieveFilterAppliedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sieve'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #sending }
ToSieveFilterAppliedEvent >> sendTo: anObject [

	anObject sieveFilterAppliedEvent: self
]

{ #category : #accessing }
ToSieveFilterAppliedEvent >> sieve [

	^ sieve
]

{ #category : #accessing }
ToSieveFilterAppliedEvent >> sieve: aSieve [

	sieve := aSieve
]
