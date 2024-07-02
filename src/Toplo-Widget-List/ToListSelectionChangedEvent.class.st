Class {
	#name : #ToListSelectionChangedEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'selectionModel',
		'touchedIndexes'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListSelectionChangedEvent >> selectedIndexes [ 

	^ self selectionModel selectedIndexes 
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectionModel: anObject [

	selectionModel := anObject
]

{ #category : #accessing }
ToListSelectionChangedEvent >> touchedIndexes [

	^ touchedIndexes
]

{ #category : #accessing }
ToListSelectionChangedEvent >> touchedIndexes: aCollection [

	touchedIndexes := aCollection
]
