Class {
	#name : #ToSelectionModelCopyFromCommand,
	#superclass : #ToSelectionModelCommand,
	#instVars : [
		'sourceSelectionModel'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToSelectionModelCopyFromCommand >> applyOn: anOperator in: aTarget [

	anOperator selectionModelCopyFromCommand: self in: aTarget.
	super applyOn: anOperator in: aTarget
]

{ #category : #accessing }
ToSelectionModelCopyFromCommand >> sourceSelectionModel [

	^ sourceSelectionModel
]

{ #category : #accessing }
ToSelectionModelCopyFromCommand >> sourceSelectionModel: aSelectionModel [

	sourceSelectionModel := aSelectionModel
]
