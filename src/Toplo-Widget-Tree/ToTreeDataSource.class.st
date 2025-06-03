Class {
	#name : #ToTreeDataSource,
	#superclass : #ToInfiniteCollectionDataSource,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #enumerating }
ToTreeDataSource >> rootsDo: aBlock [

	self do: [ :w | w isRoot ifTrue: [ aBlock value: w ] ]
]
