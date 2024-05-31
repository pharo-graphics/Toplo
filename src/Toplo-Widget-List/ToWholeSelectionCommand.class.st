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

	" ask the operator passed as argument to actually apply the command. "

	self
		deprecated: 'Use applyOnOperator: instead'
		transformWith: '`@receiver applyOn: `@argument'
			-> '`@receiver applyOnOperator: `@argument'.
	self applyOnOperator: anOperator
]

{ #category : #'private - hook' }
ToWholeSelectionCommand >> applyOnOperator: anOperator [

	self operation applyWholeSelection: self on: anOperator.
	super applyOnOperator: anOperator
]

{ #category : #accessing }
ToWholeSelectionCommand >> maxIndex [

	^ maxIndex
]

{ #category : #accessing }
ToWholeSelectionCommand >> maxIndex: anIndex [

	maxIndex := anIndex
]
