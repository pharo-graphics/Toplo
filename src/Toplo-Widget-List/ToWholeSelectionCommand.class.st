Class {
	#name : #ToWholeSelectionCommand,
	#superclass : #ToSelectionModelAddRemoveCommand,
	#instVars : [
		'maxIndex'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private - hook' }
ToWholeSelectionCommand >> applyOn: anOperator [

	self operation applyWholeSelection: self on: anOperator.
	super applyOn: anOperator
]

{ #category : #accessing }
ToWholeSelectionCommand >> maxIndex [

	^ maxIndex
]

{ #category : #accessing }
ToWholeSelectionCommand >> maxIndex: anIndex [

	maxIndex := anIndex
]
