Class {
	#name : #ToWholeSelectionCommand,
	#superclass : #ToSelectionModelAddRemoveCommand,
	#category : #'Toplo-Widget-List-Command'
}

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
