Class {
	#name : #ToListElementSieveFilterAppliedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sieve'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #sending }
ToListElementSieveFilterAppliedEvent >> sendTo: anObject [

	anObject listElementSieveFilterAppliedEvent: self
]

{ #category : #accessing }
ToListElementSieveFilterAppliedEvent >> sieve [

	^ sieve
]

{ #category : #accessing }
ToListElementSieveFilterAppliedEvent >> sieve: aSieve [

	sieve := aSieve
]
