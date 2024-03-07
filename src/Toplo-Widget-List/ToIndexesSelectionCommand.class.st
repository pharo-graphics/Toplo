Class {
	#name : #ToIndexesSelectionCommand,
	#superclass : #ToSelectionModelAddRemoveCommand,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToIndexesSelectionCommand >> applyOn: anObject in: aTarget [

	self operation applyIndexesSelection: self on: anObject.
	super applyOn: anObject in: aTarget
]

{ #category : #accessing }
ToIndexesSelectionCommand >> indexes [

	^ indexes
]

{ #category : #accessing }
ToIndexesSelectionCommand >> indexes: anArray [

	indexes := anArray
]
