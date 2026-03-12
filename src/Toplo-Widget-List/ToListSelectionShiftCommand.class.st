Class {
	#name : #ToListSelectionShiftCommand,
	#superclass : #ToListDataSourceCommand,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #application }
ToListSelectionShiftCommand >> applyIn: aFiniteListElement [

	aFiniteListElement listElement selecter
		shiftSelection: itemCount
		from: positionStart.
]

{ #category : #commands }
ToListSelectionShiftCommand >> offsetPositionsIn: anInfiniteElement [

	self applyIn: anInfiniteElement
]
