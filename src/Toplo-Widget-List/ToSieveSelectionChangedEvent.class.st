Class {
	#name : #ToSieveSelectionChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
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
