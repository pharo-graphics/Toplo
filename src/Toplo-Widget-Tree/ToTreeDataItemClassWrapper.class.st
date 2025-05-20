Class {
	#name : #ToTreeDataItemClassWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-examples'
}

{ #category : #accessing }
ToTreeDataItemClassWrapper >> dataItemChildren [

	^ dataItem subclasses asOrderedCollection
]
