Class {
	#name : #ToListDeselectWholeDataCommand,
	#superclass : #ToListWholeDataSelectionCommand,
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListDeselectWholeDataCommand >> applyOn: anObject [

	anObject listDeselectWholeDataCommand: self.
	super applyOn: anObject
]
