Class {
	#name : #ToTreeDataItemClassWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeDataItemClassWrapper >> determineChildren [

	^ dataItem subclasses asOrderedCollection
]
