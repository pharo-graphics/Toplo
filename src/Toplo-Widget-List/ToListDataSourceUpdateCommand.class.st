Class {
	#name : #ToListDataSourceUpdateCommand,
	#superclass : #ToListDataSourceCommand,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #application }
ToListDataSourceUpdateCommand >> applyIn: aFiniteListElement [ 

	aFiniteListElement onItemRangeChanged: positionStart itemCount: itemCount
]
