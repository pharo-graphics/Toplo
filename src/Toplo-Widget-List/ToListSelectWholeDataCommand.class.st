Class {
	#name : #ToListSelectWholeDataCommand,
	#superclass : #ToListWholeDataSelectionCommand,
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListSelectWholeDataCommand >> applyOn: anObject [

	anObject listSelectWholeDataCommand: self.
	super applyOn: anObject
]
