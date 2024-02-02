Class {
	#name : #ToIndexesSelectionCommand,
	#superclass : #ToSelectionCommand,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #hook }
ToIndexesSelectionCommand >> applyOn: anObject [

	self operation applyIndexesSelection: self on: anObject.
	super applyOn: anObject
]

{ #category : #accessing }
ToIndexesSelectionCommand >> indexes [

	^ indexes
]

{ #category : #accessing }
ToIndexesSelectionCommand >> indexes: anArray [

	indexes := anArray
]
