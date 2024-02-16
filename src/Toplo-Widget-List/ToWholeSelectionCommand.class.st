Class {
	#name : #ToWholeSelectionCommand,
	#superclass : #ToSelectionModelAddRemoveCommand,
	#instVars : [
		'maxIndex'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToWholeSelectionCommand >> applyOn: anObject for: aTarget [

	self operation applyWholeSelection: self on: anObject.
	super applyOn: anObject for: aTarget
]

{ #category : #accessing }
ToWholeSelectionCommand >> maxIndex [

	^ maxIndex
]

{ #category : #accessing }
ToWholeSelectionCommand >> maxIndex: anIndex [

	maxIndex := anIndex
]
