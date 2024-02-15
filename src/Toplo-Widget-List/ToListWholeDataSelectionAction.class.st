Class {
	#name : #ToListWholeDataSelectionAction,
	#superclass : #ToListSelectionAction,
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #testing }
ToListWholeDataSelectionAction class >> isDeprecated [ 

	^ true
]

{ #category : #hook }
ToListWholeDataSelectionAction >> applyOn: anObject [

	anObject listWholeDataSelectionAction: self.
	super applyOn: anObject
]
