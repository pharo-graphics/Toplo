Class {
	#name : #ToListSelectionChangedEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'selectionOption',
		'selectionModel',
		'touchedIntervals'
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
ToListSelectionChangedEvent >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectionOption: aSelectionElementOption [

	selectionOption := aSelectionElementOption
]

{ #category : #accessing }
ToListSelectionChangedEvent >> touchedIntervals [

	^  touchedIntervals 
]

{ #category : #accessing }
ToListSelectionChangedEvent >> touchedIntervals: aCollection [

	touchedIntervals := aCollection
]
