Class {
	#name : #ToListSelectToIndexCommand,
	#superclass : #ToListSelectionMonoIndexCommand,
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListSelectToIndexCommand >> applyOn: anObject [

	anObject listSelectToIndexCommand: self.
	super applyOn: anObject 
]
