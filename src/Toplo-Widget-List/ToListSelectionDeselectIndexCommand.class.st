Class {
	#name : #ToListSelectionDeselectIndexCommand,
	#superclass : #ToListSelectionMonoIndexCommand,
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListSelectionDeselectIndexCommand >> applyOn: anObject [

	anObject listSelectionDeselectIndexCommand: self.
	super applyOn: anObject
]
