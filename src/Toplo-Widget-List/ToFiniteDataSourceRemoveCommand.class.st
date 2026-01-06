Class {
	#name : #ToFiniteDataSourceRemoveCommand,
	#superclass : #ToFiniteDataSourceCommand,
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #commands }
ToFiniteDataSourceRemoveCommand >> offsetPositionsIn: aFiniteElement [

	aFiniteElement onItemRangeRemoved: positionStart itemCount: itemCount.
	" update the secondary selection because it can be on the removed nodes "
	aFiniteElement listElement secondarySelecter
		deselectIndex: positionStart
		to: positionStart + itemCount - 1.
	aFiniteElement listElement selecter
		shiftSelection: itemCount negated
		from: positionStart
]
