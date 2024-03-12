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
ToSelectionModelShiftCommand >> applyOn: anOperator in: aTarget [

	anOperator selectionModelShiftCommand: self in: aTarget.
	super applyOn: anOperator in: aTarget
]

{ #category : #accessing }
ToSelectionModelShiftCommand >> fromIndex [

	^ fromIndex
]

{ #category : #accessing }
ToSelectionModelShiftCommand >> fromIndex: anIndex [

	fromIndex := anIndex
]

{ #category : #initialization }
ToSelectionModelShiftCommand >> initialize [

	super initialize.
	"self silent: true"
]

{ #category : #accessing }
ToSelectionModelShiftCommand >> itemCount [

	^ itemCount
]

{ #category : #accessing }
ToSelectionModelShiftCommand >> itemCount: anInteger [

	itemCount := anInteger
]
