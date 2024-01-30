Class {
	#name : #ToListWholeDataSelectionAction,
	#superclass : #ToListSelectionAction,
	#category : #'Toplo-Widget-List-SelectionAction'
}

{ #category : #hook }
ToListWholeDataSelectionAction >> applyOn: anObject [

	anObject listWholeDataSelectionAction: self.
	super applyOn: anObject
]
