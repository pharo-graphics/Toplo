Class {
	#name : #ToSelectionCopyFromCommand,
	#superclass : #ToSelectionCommand,
	#instVars : [
		'sourceSelectionModel'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - hook' }
ToSelectionCopyFromCommand >> applyOn: anOperator [

	" ask the operator passed as argument to actually apply the command. "

	self
		deprecated: 'Use applyOnOperator: instead'
		transformWith: '`@receiver applyOn: `@argument'
			-> '`@receiver applyOnOperator: `@argument'.
	self applyWithOperator: anOperator
]

{ #category : #'private - hook' }
ToSelectionCopyFromCommand >> applyWithOperator: anOperator [

	anOperator selectionModelCopyFromCommand: self.
	super applyWithOperator: anOperator 
]

{ #category : #accessing }
ToSelectionCopyFromCommand >> indexes [ 

	^ 1 to: sourceSelectionModel itemCount
]

{ #category : #accessing }
ToSelectionCopyFromCommand >> intervals [ 

	^ Array with: (1 to: sourceSelectionModel itemCount)
]

{ #category : #application }
ToSelectionCopyFromCommand >> onAppliedOn: aCommandApplier [

	aCommandApplier onSelectionCopyCommandApplied: self
]

{ #category : #accessing }
ToSelectionCopyFromCommand >> sourceSelectionModel [

	^ sourceSelectionModel
]

{ #category : #accessing }
ToSelectionCopyFromCommand >> sourceSelectionModel: aSelectionModel [

	sourceSelectionModel := aSelectionModel
]
