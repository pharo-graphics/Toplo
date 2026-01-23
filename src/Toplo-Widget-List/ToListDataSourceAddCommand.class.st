Class {
	#name : #ToListDataSourceAddCommand,
	#superclass : #ToListDataSourceCommand,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #application }
ToListDataSourceAddCommand >> applyIn: aFiniteListElement [ 

	aFiniteListElement listElement selecter
		shiftSelection: itemCount
		from: positionStart.
	aFiniteListElement onItemRangeInserted: positionStart itemCount: itemCount.

]
