Class {
	#name : #ToSelectionModelShiftCommand,
	#superclass : #ToSelectionModelCommand,
	#instVars : [
		'fromIndex',
		'itemCount'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToSelectionModelShiftCommand >> applyOn: anObject for: aTarget [

	anObject selectionModelShiftCommand: self
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
