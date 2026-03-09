Class {
	#name : #ToListDataSourceChangedCommand,
	#superclass : #ToListDataSourceCommand,
	#category : #'Toplo-Widget-List'
}

{ #category : #application }
ToListDataSourceChangedCommand >> applyIn: aFiniteListElement [

	aFiniteListElement onItemsChanged
]
