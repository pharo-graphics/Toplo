Class {
	#name : #ToIndexesSelectionCommand,
	#superclass : #ToSelectionModelCommand,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Command'
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
