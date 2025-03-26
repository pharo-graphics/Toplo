Class {
	#name : #ToAbstractBarNodeManager,
	#superclass : #ToAbstractNodeManager,
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToAbstractBarNodeManager >> applyFakeNodeConstraintsOn: aNode [

	| bar |
	bar := aNode holder listElement.
	self applyNodeConstraintsOn: aNode.
	bar isHorizontal
		ifTrue: [ aNode constraintsDo: [ :c | c horizontal exact: 0 ] ]
		ifFalse: [ aNode constraintsDo: [ :c | c vertical exact: 0 ] ]
]

{ #category : #initialization }
ToAbstractBarNodeManager >> constraintFakeNode: aNode [

	self
		deprecated: 'Use #applyFakeNodeConstraintsOn:'
		transformWith: '`@rcvr constraintFakeNode: `@arg'
			-> '`@rcvr applyFakeNodeConstraintsOn: `@arg'.
	self applyFakeNodeConstraintsOn: aNode
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
