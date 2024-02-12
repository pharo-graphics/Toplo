Class {
	#name : #ToSelectionModelCommand,
	#superclass : #ToListElementCommand,
	#instVars : [
		'operation'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #accessing }
ToSelectionModelCommand >> operation [

	^ operation
]

{ #category : #accessing }
ToSelectionModelCommand >> operation: aSelectionOperation [

	operation := aSelectionOperation
]
