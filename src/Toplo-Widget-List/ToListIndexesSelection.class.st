Class {
	#name : #ToListIndexesSelection,
	#superclass : #ToListSelectionCommand,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #hook }
ToListIndexesSelection >> applyOn: anObject [

	self operation applyListIndexesSelection: self on: anObject.
	super applyOn: anObject
]

{ #category : #accessing }
ToListIndexesSelection >> indexes [

	^ indexes
]

{ #category : #accessing }
ToListIndexesSelection >> indexes: anArray [

	indexes := anArray
]
