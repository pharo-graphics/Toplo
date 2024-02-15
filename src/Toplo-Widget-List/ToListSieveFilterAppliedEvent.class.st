Class {
	#name : #ToListSieveFilterAppliedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sieve'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #sending }
ToListSieveFilterAppliedEvent >> sendTo: anObject [

	anObject listSieveFilterAppliedEvent: self
]

{ #category : #accessing }
ToListSieveFilterAppliedEvent >> sieve [

	^ sieve
]

{ #category : #accessing }
ToListSieveFilterAppliedEvent >> sieve: aSieve [

	sieve := aSieve
]
