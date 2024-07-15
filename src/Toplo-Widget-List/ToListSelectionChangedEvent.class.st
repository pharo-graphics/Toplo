Class {
	#name : #ToListSelectionChangedEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListSelectionChangedEvent >> command [

	^ command 
]

{ #category : #accessing }
ToListSelectionChangedEvent >> command: aCommand [

	command := aCommand
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectedIndexes [ 

	^ self selectionModel selectedIndexes 
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectionModel [

	^ command selectionModel
]

{ #category : #accessing }
ToListSelectionChangedEvent >> touchedIndexes [

	^ command indexes
]

{ #category : #accessing }
ToListSelectionChangedEvent >> touchedIntervals [

	^ command touchedIntervals 
]
