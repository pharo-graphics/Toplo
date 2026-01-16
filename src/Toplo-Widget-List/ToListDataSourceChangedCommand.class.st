Class {
	#name : #ToListDataSourceChangedCommand,
	#superclass : #ToListDataSourceCommand,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #application }
ToListDataSourceChangedCommand >> applyIn: aFiniteListElement [

	aFiniteListElement onItemsChanged
]
