Class {
	#name : #ToIndexesSelectionCommand,
	#superclass : #ToSelectionModelAddRemoveCommand,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - hook' }
ToIndexesSelectionCommand >> applyOn: anOperator [

	" ask the operator passed as argument to actually apply the command. "

	self
		deprecated: 'Use applyOnOperator: instead'
		transformWith: '`@receiver applyOn: `@argument'
			-> '`@receiver applyOnOperator: `@argument'.
	self applyWithOperator: anOperator
]

{ #category : #'private - hook' }
ToIndexesSelectionCommand >> applyWithOperator: anOperator [ 

	self operation applyIndexesSelection: self on: anOperator.
	super applyWithOperator: anOperator
]

{ #category : #accessing }
ToIndexesSelectionCommand >> indexes [

	^ indexes
]

{ #category : #accessing }
ToIndexesSelectionCommand >> indexes: anArray [

	indexes := anArray
]
