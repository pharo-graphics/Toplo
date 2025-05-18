Class {
	#name : #ToTreeDataItemClassWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-examples'
}

{ #category : #accessing }
ToTreeDataItemClassWrapper >> computedChildren [

	^ dataItem subclasses asOrderedCollection
]
