Class {
	#name : #ToFiniteDataSourceUpdateCommand,
	#superclass : #ToFiniteDataSourceCommand,
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #commands }
ToFiniteDataSourceUpdateCommand >> offsetPositionsIn: aFiniteElement [

	aFiniteElement onItemRangeChanged: positionStart itemCount: itemCount
]
