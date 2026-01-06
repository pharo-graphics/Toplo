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
