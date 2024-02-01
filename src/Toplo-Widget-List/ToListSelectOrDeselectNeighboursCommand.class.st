Class {
	#name : #ToListSelectOrDeselectNeighboursCommand,
	#superclass : #ToListSelectionCommandDeprecated,
	#instVars : [
		'number'
	],
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListSelectOrDeselectNeighboursCommand >> applyOn: anObject [

	anObject listSelectOrDeselectNeighboursCommand: self.
	super applyOn: anObject
]

{ #category : #accessing }
ToListSelectOrDeselectNeighboursCommand >> number [

	^ number
]

{ #category : #accessing }
ToListSelectOrDeselectNeighboursCommand >> number: anInteger [

	" a negative number means x nodes before the current index "
	number := anInteger
]
