Class {
	#name : #ToListWholeSelection,
	#superclass : #ToListSelectionCommand,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #hook }
ToListWholeSelection >> applyOn: anObject [

	self operation applyListWholeSelection: self on: anObject.
	super applyOn: anObject	
]
