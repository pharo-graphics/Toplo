Class {
	#name : #ToListSelectionCherryPickCommand,
	#superclass : #ToListSelectionMonoIndexCommand,
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListSelectionCherryPickCommand >> applyOn: anObject [

	anObject listSelectionCherryPickCommand: self.
	super applyOn: anObject
]
