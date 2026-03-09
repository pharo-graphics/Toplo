Class {
	#name : #ToSelectionAddRemoveCommand,
	#superclass : #ToSelectionCommand,
	#instVars : [
		'operation'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToSelectionAddRemoveCommand >> indexes [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectionAddRemoveCommand >> operation [

	^ operation
]

{ #category : #accessing }
ToSelectionAddRemoveCommand >> operation: aSelectionOperation [

	operation := aSelectionOperation
]
