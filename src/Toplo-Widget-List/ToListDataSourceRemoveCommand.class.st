Class {
	#name : #ToListDataSourceRemoveCommand,
	#superclass : #ToListDataSourceCommand,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #application }
ToListDataSourceRemoveCommand >> applyIn: aFiniteListElement [ 

	aFiniteListElement onItemRangeRemoved: positionStart itemCount: itemCount.
	" update the secondary selection because it can be on the removed nodes "
	aFiniteListElement listElement secondarySelecter
		deselectIndex: positionStart
		to: positionStart + itemCount - 1.
	aFiniteListElement listElement selecter
		shiftSelection: itemCount negated
		from: positionStart
]
