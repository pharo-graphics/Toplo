Class {
	#name : #ToSelectionModelCopyFromCommand,
	#superclass : #ToSelectionModelCommand,
	#instVars : [
		'sourceSelectionModel'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - hook' }
ToSelectionModelCopyFromCommand >> applyWithOperator: anOperator [

	anOperator selectionModelCopyFromCommand: self.
	super applyWithOperator: anOperator 
]

{ #category : #accessing }
ToSelectionModelCopyFromCommand >> indexes [ 

	^ 1 to: sourceSelectionModel itemCount
]

{ #category : #accessing }
ToSelectionModelCopyFromCommand >> intervals [ 

	^ Array with: (1 to: sourceSelectionModel itemCount)
]

{ #category : #accessing }
ToSelectionModelCopyFromCommand >> sourceSelectionModel [

	^ sourceSelectionModel
]

{ #category : #accessing }
ToSelectionModelCopyFromCommand >> sourceSelectionModel: aSelectionModel [

	sourceSelectionModel := aSelectionModel
]
