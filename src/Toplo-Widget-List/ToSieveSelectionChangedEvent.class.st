Class {
	#name : #ToSieveSelectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sieve',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #accessing }
ToSieveSelectionChangedEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToSieveSelectionChangedEvent >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #sending }
ToSieveSelectionChangedEvent >> sendTo: anObject [

	anObject sieveSelectionChangedEvent: self
]

{ #category : #accessing }
ToSieveSelectionChangedEvent >> sieve [

	^ sieve
]

{ #category : #accessing }
ToSieveSelectionChangedEvent >> sieve: aSieve [

	sieve := aSieve
]
