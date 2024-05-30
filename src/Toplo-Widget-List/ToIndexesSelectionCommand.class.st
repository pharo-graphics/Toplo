Class {
	#name : #ToIndexesSelectionCommand,
	#superclass : #ToSelectionModelAddRemoveCommand,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private - hook' }
ToIndexesSelectionCommand >> applyOn: anOperator [ 

	self operation applyIndexesSelection: self on: anOperator.
	super applyOn: anOperator
]

{ #category : #accessing }
ToIndexesSelectionCommand >> indexes [

	^ indexes
]

{ #category : #accessing }
ToIndexesSelectionCommand >> indexes: anArray [

	indexes := anArray
]
