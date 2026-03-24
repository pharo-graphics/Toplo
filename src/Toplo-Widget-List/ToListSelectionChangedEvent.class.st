Class {
	#name : #ToListSelectionChangedEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'selectionOption',
		'appliedCommand'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListSelectionChangedEvent >> appliedCommand [

	^ appliedCommand
]

{ #category : #accessing }
ToListSelectionChangedEvent >> appliedCommand: aCommand [

	appliedCommand := aCommand
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectedIndexes [ 

	^ self selectionModel selectedIndexes 
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectionModel [

	^ appliedCommand selectionModel
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToListSelectionChangedEvent >> selectionOption: aSelectionElementOption [

	selectionOption := aSelectionElementOption
]
