Class {
	#name : #ToListSieveSelectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sieve',
		'originalData',
		'selection'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #accessing }
ToListSieveSelectionChangedEvent >> originalData [

	^ originalData
]

{ #category : #accessing }
ToListSieveSelectionChangedEvent >> originalData: aCollection [

	originalData := aCollection
]

{ #category : #accessing }
ToListSieveSelectionChangedEvent >> selection [

	^ selection
]

{ #category : #accessing }
ToListSieveSelectionChangedEvent >> selection: aSelection [

	selection := aSelection
]

{ #category : #sending }
ToListSieveSelectionChangedEvent >> sendTo: anObject [

	anObject listSieveSelectionChangedEvent: self
]

{ #category : #accessing }
ToListSieveSelectionChangedEvent >> sieve [

	^ sieve
]

{ #category : #accessing }
ToListSieveSelectionChangedEvent >> sieve: aSieve [

	sieve := aSieve
]
