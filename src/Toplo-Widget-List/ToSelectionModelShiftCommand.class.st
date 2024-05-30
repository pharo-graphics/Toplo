Class {
	#name : #ToSelectionModelShiftCommand,
	#superclass : #ToSelectionModelCommand,
	#instVars : [
		'fromIndex',
		'itemCount'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private - hook' }
ToSelectionModelShiftCommand >> applyOn: anOperator [

	anOperator selectionModelShiftCommand: self.
	super applyOn: anOperator
]

{ #category : #accessing }
ToSelectionModelShiftCommand >> fromIndex [

	^ fromIndex
]

{ #category : #accessing }
ToSelectionModelShiftCommand >> fromIndex: anIndex [

	fromIndex := anIndex
]

{ #category : #accessing }
ToSelectionModelShiftCommand >> itemCount [

	^ itemCount
]

{ #category : #accessing }
ToSelectionModelShiftCommand >> itemCount: anInteger [

	itemCount := anInteger
]
