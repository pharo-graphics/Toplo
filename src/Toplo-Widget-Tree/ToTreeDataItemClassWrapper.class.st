Class {
	#name : #ToTreeDataItemClassWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree'
}

{ #category : #'as yet unclassified' }
ToTreeDataItemClassWrapper >> determineChildren [

	children := dataItem subclasses asOrderedCollection
]
