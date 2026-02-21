Class {
	#name : #ToListSelectionShiftCommand,
	#superclass : #ToListDataSourceCommand,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #application }
ToListSelectionShiftCommand >> applyIn: aFiniteListElement [


]

{ #category : #commands }
ToListSelectionShiftCommand >> offsetPositionsIn: anInfiniteElement [

	anInfiniteElement listElement selecter
		shiftSelection: itemCount
		from: positionStart.
]
