Class {
	#name : #ToFiniteDataSourceAddCommand,
	#superclass : #ToFiniteDataSourceCommand,
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #commands }
ToFiniteDataSourceAddCommand >> offsetPositionsIn: aFiniteElement [

	aFiniteElement onItemRangeInserted: positionStart itemCount: itemCount.
	aFiniteElement listElement selecter
		shiftSelection: itemCount
		from: positionStart
]
