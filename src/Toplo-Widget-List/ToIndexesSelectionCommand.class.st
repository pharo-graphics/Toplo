Class {
	#name : #ToIndexesSelectionCommand,
	#superclass : #ToSelectionAddRemoveCommand,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'instance creation' }
ToIndexesSelectionCommand class >> add: indexes [

	^ self new
		  indexes: indexes;
		  operation: ToAddSelectionOperation new;
		  yourself
]

{ #category : #'instance creation' }
ToIndexesSelectionCommand class >> remove: indexes [

	^ self new
		  indexes: indexes;
		  operation: ToRemoveSelectionOperation new;
		  yourself
]

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

{ #category : #accessing }
ToIndexesSelectionCommand >> intervals [

	^ self intervalsIn: indexes
]
