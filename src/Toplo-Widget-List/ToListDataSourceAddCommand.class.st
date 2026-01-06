Class {
	#name : #ToListDataSourceAddCommand,
	#superclass : #ToListDataSourceCommand,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #application }
ToListDataSourceAddCommand >> applyIn: aFiniteListElement [ 

	aFiniteListElement onItemRangeInserted: positionStart itemCount: itemCount.
	aFiniteListElement listElement selecter
		shiftSelection: itemCount
		from: positionStart
]
