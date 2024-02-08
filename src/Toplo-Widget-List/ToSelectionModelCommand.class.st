Class {
	#name : #ToSelectionModelCommand,
	#superclass : #ToSelectionCommand,
	#instVars : [
		'operation'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #accessing }
ToSelectionModelCommand >> operation [

	^ operation
]

{ #category : #accessing }
ToSelectionModelCommand >> operation: aSelectionOperation [

	operation := aSelectionOperation
]
