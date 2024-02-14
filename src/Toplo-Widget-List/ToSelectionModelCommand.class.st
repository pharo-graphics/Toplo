Class {
	#name : #ToSelectionModelCommand,
	#superclass : #ToBasicCommand,
	#instVars : [
		'operation'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #accessing }
ToSelectionModelCommand >> operation [

	^ operation
]

{ #category : #accessing }
ToSelectionModelCommand >> operation: aSelectionOperation [

	operation := aSelectionOperation
]
