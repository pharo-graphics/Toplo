Class {
	#name : #ToListElementSieveSelectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sieve',
		'originalData',
		'selection'
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

{ #category : #accessing }
ToListElementSieveSelectionChangedEvent >> selection [

	^ selection
]

{ #category : #accessing }
ToListElementSieveSelectionChangedEvent >> selection: aSelection [

	selection := aSelection
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
