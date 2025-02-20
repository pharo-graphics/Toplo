Class {
	#name : #ToTreeDataItemClassWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeDataItemClassWrapper >> computedChildren [

	^ dataItem subclasses asOrderedCollection
]
