Class {
	#name : #ToSelectionModelCopyFromCommand,
	#superclass : #ToSelectionModelCommand,
	#instVars : [
		'sourceSelectionModel'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private - hook' }
ToSelectionModelCopyFromCommand >> applyOn: anOperator [

	anOperator selectionModelCopyFromCommand: self.
	super applyOn: anOperator 
]

{ #category : #accessing }
ToSelectionModelCopyFromCommand >> sourceSelectionModel [

	^ sourceSelectionModel
]

{ #category : #accessing }
ToSelectionModelCopyFromCommand >> sourceSelectionModel: aSelectionModel [

	sourceSelectionModel := aSelectionModel
]
