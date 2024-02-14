Class {
	#name : #ToIndexesSelectionCommand,
	#superclass : #ToSelectionModelCommand,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToIndexesSelectionCommand >> applyOn: anObject for: aTarget [

	self operation applyIndexesSelection: self on: anObject.
	super applyOn: anObject for: aTarget
]

{ #category : #accessing }
ToIndexesSelectionCommand >> indexes [

	^ indexes
]

{ #category : #accessing }
ToIndexesSelectionCommand >> indexes: anArray [

	indexes := anArray
]
