Class {
	#name : #ToSieveFilterApplyRequestEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sieve'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #sending }
ToSieveFilterApplyRequestEvent >> sendTo: anObject [

	anObject sieveFilterApplyRequestEvent: self
]

{ #category : #accessing }
ToSieveFilterApplyRequestEvent >> sieve [

	^ sieve
]

{ #category : #accessing }
ToSieveFilterApplyRequestEvent >> sieve: aSieve [

	sieve := aSieve
]
