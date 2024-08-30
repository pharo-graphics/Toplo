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
	self applyWithOperator: anOperator
]

{ #category : #'private - hook' }
ToSelectionModelShiftCommand >> applyWithOperator: anOperator [

	anOperator selectionModelShiftCommand: self.
	super applyWithOperator: anOperator
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
ToSelectionModelShiftCommand >> indexes [ 

	^ fromIndex to: fromIndex + itemCount - 1
]

{ #category : #accessing }
ToSelectionModelShiftCommand >> intervals [ 

	^ Array with: (fromIndex to: fromIndex + itemCount - 1)
]

{ #category : #accessing }
ToSelectionModelShiftCommand >> itemCount [

	^ itemCount
]

{ #category : #accessing }
ToSelectionModelShiftCommand >> itemCount: anInteger [

	itemCount := anInteger
]
