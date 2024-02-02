Class {
	#name : #ToWholeSelectionCommand,
	#superclass : #ToSelectionCommand,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #hook }
ToWholeSelectionCommand >> applyOn: anObject [

	self operation applyWholeSelection: self on: anObject.
	super applyOn: anObject	
]
