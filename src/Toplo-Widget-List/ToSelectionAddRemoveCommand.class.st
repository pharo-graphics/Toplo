Class {
	#name : #ToSelectionAddRemoveCommand,
	#superclass : #ToSelectionCommand,
	#instVars : [
		'operation'
	],
	#category : #'Toplo-Widget-List-Command'
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

{ #category : #testing }
ToSelectionAddRemoveCommand >> selectsBeyond: anItemCount [
	"Only additions are concerned, removals beyond anItemCount are harmless"

	^ operation isAdd and: [ self indexes anySatisfy: [ :i | i > anItemCount ] ]
]
