Class {
	#name : #ToListSelectionDeselectAllIndexesCommand,
	#superclass : #ToListSelectionMultipleIndexCommand,
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListSelectionDeselectAllIndexesCommand >> applyOn: anObject [

	anObject listSelectionDeselectAllIndexesCommand: self.
	super applyOn: anObject
]
