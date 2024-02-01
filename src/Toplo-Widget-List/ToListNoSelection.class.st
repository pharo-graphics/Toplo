Class {
	#name : #ToListNoSelection,
	#superclass : #ToListSelectionCommand,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #hook }
ToListNoSelection >> applyOn: anObject [

	self operation applyListNoSelection: self on: anObject.
	super applyOn: anObject
]
