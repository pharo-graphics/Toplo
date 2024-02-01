Class {
	#name : #ToListSelectionMultipleIndexCommand,
	#superclass : #ToListSelectionCommandDeprecated,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListSelectionMultipleIndexCommand >> applyOn: anObject [

	anObject listSelectionCherryPickCommand: self.
	super applyOn: anObject
]

{ #category : #accessing }
ToListSelectionMultipleIndexCommand >> indexes [

	^ indexes
]

{ #category : #accessing }
ToListSelectionMultipleIndexCommand >> indexes: anArray [

	indexes := anArray
]
