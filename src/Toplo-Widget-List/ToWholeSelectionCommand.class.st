Class {
	#name : #ToWholeSelectionCommand,
	#superclass : #ToSelectionModelAddRemoveCommand,
	#instVars : [
		'maxIndex'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToWholeSelectionCommand >> applyOn: anOperator in: aTarget [

	self operation applyWholeSelection: self on: anOperator.
	super applyOn: anOperator in: aTarget
]

{ #category : #accessing }
ToWholeSelectionCommand >> maxIndex [

	^ maxIndex
]

{ #category : #accessing }
ToWholeSelectionCommand >> maxIndex: anIndex [

	maxIndex := anIndex
]
