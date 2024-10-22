Class {
	#name : #ToSelectionAddRemoveCommand,
	#superclass : #ToSelectionCommand,
	#instVars : [
		'operation'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #accessing }
ToSelectionAddRemoveCommand >> operation [

	^ operation
]

{ #category : #accessing }
ToSelectionAddRemoveCommand >> operation: aSelectionOperation [

	operation := aSelectionOperation
]
