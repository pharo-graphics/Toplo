Class {
	#name : #ToTreeDataItemClassWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'as yet unclassified' }
ToTreeDataItemClassWrapper >> determineChildren [

	^ dataItem subclasses asOrderedCollection
]
