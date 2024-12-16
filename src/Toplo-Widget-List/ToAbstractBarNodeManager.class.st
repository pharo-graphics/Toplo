Class {
	#name : #ToAbstractBarNodeManager,
	#superclass : #ToAbstractNodeManager,
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToAbstractBarNodeManager >> constraintFakeNode: aNode [

	| bar |
	bar := aNode holder listElement.
	bar isHorizontal
		ifTrue: [
			aNode constraintsDo: [ :c |
				c horizontal exact: 0.
				c vertical fitContent.
				c flow vertical alignCenter.
				c linear vertical alignCenter ] ]
		ifFalse: [
			aNode constraintsDo: [ :c |
				c vertical exact: 0.
				c horizontal fitContent.
				c flow horizontal alignCenter.
				c linear horizontal alignCenter ] ].
]

{ #category : #initialization }
ToAbstractBarNodeManager >> constraintNode: aNode [

	| bar |
	bar := aNode holder listElement.
	aNode constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	aNode constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter.
		c linear horizontal alignCenter.
		c flow horizontal alignCenter ].
	bar nodeScrolling ifTrue: [ ^ self ].
	bar nodeAutoDistribution ifTrue: [
		bar isHorizontal
			ifTrue: [ aNode hMatchParent ]
			ifFalse: [ aNode vMatchParent ] ]
]

{ #category : #initialization }
ToAbstractBarNodeManager >> defaultFakeDataItem [

	^ nil
]

{ #category : #accessing }
ToAbstractBarNodeManager >> fakeDataItem [

	^ fakeDataItem
]

{ #category : #accessing }
ToAbstractBarNodeManager >> fakeDataItem: anObject [

	fakeDataItem := anObject
]

{ #category : #initialization }
ToAbstractBarNodeManager >> initialize [ 

	super initialize.
	fakeDataItem := self defaultFakeDataItem 
]

{ #category : #'instance creation' }
ToAbstractBarNodeManager >> newFakeNodeIn: anInnerBarElement [

	| holder fakeNode |
	holder := self newHolder.
	holder infiniteElement: anInnerBarElement.
	holder dataItem: fakeDataItem.
	holder bindAtPosition: 0.
	fakeNode := self newNodeForHolder: holder.
	fakeNode id: #fakeNode.
	holder setupNodeWith: fakeNode.
	^ fakeNode
]
