Class {
	#name : #ToSelectionShiftCommand,
	#superclass : #ToSelectionCommand,
	#instVars : [
		'fromIndex',
		'itemCount'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - hook' }
ToSelectionShiftCommand >> applyWithOperator: anOperator [

	anOperator selectionModelShiftCommand: self.
	super applyWithOperator: anOperator
]

{ #category : #accessing }
ToSelectionShiftCommand >> fromIndex [

	^ fromIndex
]

{ #category : #accessing }
ToSelectionShiftCommand >> fromIndex: anIndex [

	fromIndex := anIndex
]

{ #category : #accessing }
ToSelectionShiftCommand >> indexes [ 

	^ fromIndex to: fromIndex + itemCount - 1
]

{ #category : #accessing }
ToSelectionShiftCommand >> intervals [ 

	^ Array with: (fromIndex to: fromIndex + itemCount - 1)
]

{ #category : #accessing }
ToSelectionShiftCommand >> itemCount [

	^ itemCount
]

{ #category : #accessing }
ToSelectionShiftCommand >> itemCount: anInteger [

	itemCount := anInteger
]

{ #category : #application }
ToSelectionShiftCommand >> onAppliedOn: aCommandApplier [

	aCommandApplier onSelectionShiftCommandApplied: self
]
