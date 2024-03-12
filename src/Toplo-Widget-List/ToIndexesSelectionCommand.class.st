Class {
	#name : #ToIndexesSelectionCommand,
	#superclass : #ToSelectionModelAddRemoveCommand,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToIndexesSelectionCommand >> applyOn: anOperator in: aTarget [

	self operation applyIndexesSelection: self on: anOperator.
	super applyOn: anOperator in: aTarget
]

{ #category : #accessing }
ToIndexesSelectionCommand >> indexes [

	^ indexes
]

{ #category : #accessing }
ToIndexesSelectionCommand >> indexes: anArray [

	indexes := anArray
]
