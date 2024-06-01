Class {
	#name : #ToSelectionModelShiftCommand,
	#superclass : #ToSelectionModelCommand,
	#instVars : [
		'fromIndex',
		'itemCount'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - hook' }
ToSelectionModelShiftCommand >> applyOn: anOperator [

	" ask the operator passed as argument to actually apply the command. "

	self
		deprecated: 'Use applyOnOperator: instead'
		transformWith: '`@receiver applyOn: `@argument'
			-> '`@receiver applyOnOperator: `@argument'.
	self applyOnOperator: anOperator
]

{ #category : #'private - hook' }
ToSelectionModelShiftCommand >> applyOnOperator: anOperator [

	anOperator selectionModelShiftCommand: self.
	super applyOnOperator: anOperator
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
