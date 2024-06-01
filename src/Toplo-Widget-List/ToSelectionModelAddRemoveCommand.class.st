Class {
	#name : #ToSelectionModelAddRemoveCommand,
	#superclass : #ToSelectionModelCommand,
	#instVars : [
		'operation'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #accessing }
ToSelectionModelAddRemoveCommand >> operation [

	^ operation
]

{ #category : #accessing }
ToSelectionModelAddRemoveCommand >> operation: aSelectionOperation [

	operation := aSelectionOperation
]
