Class {
	#name : #ToBarNodeHolder,
	#superclass : #ToListNodeHolder,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToBarNodeHolder >> barElement [

	^ self listElement
]

{ #category : #accessing }
ToBarNodeHolder >> changeDataItem: aDataItem [

	| nodeManager |
	nodeManager := self nodeManager.
	nodeManager unbuildNode: self node.
	self dataItem: aDataItem.
	self build
]
