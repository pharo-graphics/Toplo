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
	self applyWithOperator: anOperator
]

{ #category : #'private - hook' }
ToSelectionModelCopyFromCommand >> applyWithOperator: anOperator [

	anOperator selectionModelCopyFromCommand: self.
	super applyWithOperator: anOperator 
]

{ #category : #accessing }
ToSelectionModelCopyFromCommand >> sourceSelectionModel [

	^ sourceSelectionModel
]

{ #category : #accessing }
ToSelectionModelCopyFromCommand >> sourceSelectionModel: aSelectionModel [

	sourceSelectionModel := aSelectionModel
]
