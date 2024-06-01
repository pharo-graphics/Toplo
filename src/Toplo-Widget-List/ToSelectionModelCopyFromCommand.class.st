Class {
	#name : #ToSelectionModelCopyFromCommand,
	#superclass : #ToSelectionModelCommand,
	#instVars : [
		'sourceSelectionModel'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - hook' }
ToSelectionModelCopyFromCommand >> applyOn: anOperator [

	" ask the operator passed as argument to actually apply the command. "

	self
		deprecated: 'Use applyOnOperator: instead'
		transformWith: '`@receiver applyOn: `@argument'
			-> '`@receiver applyOnOperator: `@argument'.
	self applyOnOperator: anOperator
]

{ #category : #'private - hook' }
ToSelectionModelCopyFromCommand >> applyOnOperator: anOperator [

	anOperator selectionModelCopyFromCommand: self.
	super applyOnOperator: anOperator 
]

{ #category : #accessing }
ToSelectionModelCopyFromCommand >> sourceSelectionModel [

	^ sourceSelectionModel
]

{ #category : #accessing }
ToSelectionModelCopyFromCommand >> sourceSelectionModel: aSelectionModel [

	sourceSelectionModel := aSelectionModel
]
