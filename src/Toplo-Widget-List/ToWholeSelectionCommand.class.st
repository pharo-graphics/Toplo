Class {
	#name : #ToWholeSelectionCommand,
	#superclass : #ToSelectionAddRemoveCommand,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - hook' }
ToWholeSelectionCommand >> applyOn: anOperator [

	" ask the operator passed as argument to actually apply the command. "

	self
		deprecated: 'Use applyOnOperator: instead'
		transformWith: '`@receiver applyOn: `@argument'
			-> '`@receiver applyOnOperator: `@argument'.
	self applyWithOperator: anOperator
]

{ #category : #'private - hook' }
ToWholeSelectionCommand >> applyWithOperator: anOperator [

	self operation applyWholeSelection: self on: anOperator.
	super applyWithOperator: anOperator
]

{ #category : #accessing }
ToWholeSelectionCommand >> indexes [ 

	^ 1 to: selectionModel itemCount
]

{ #category : #accessing }
ToWholeSelectionCommand >> intervals [ 

	^ Array with: (1 to: selectionModel itemCount)
]
