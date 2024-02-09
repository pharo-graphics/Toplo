Class {
	#name : #ToListElementSieveSelectionChangedEvent,
	#superclass : #ToListSelectionChangedEvent,
	#instVars : [
		'sieve',
		'originalData'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #accessing }
ToListElementSieveSelectionChangedEvent >> originalData [

	^ originalData
]

{ #category : #accessing }
ToListElementSieveSelectionChangedEvent >> originalData: aCollection [

	originalData := aCollection
]

{ #category : #sending }
ToListElementSieveSelectionChangedEvent >> sendTo: anObject [

	anObject listElementSieveSelectionChangedEvent: self
]

{ #category : #accessing }
ToListElementSieveSelectionChangedEvent >> sieve [

	^ sieve
]

{ #category : #accessing }
ToListElementSieveSelectionChangedEvent >> sieve: aSieve [

	sieve := aSieve
]
