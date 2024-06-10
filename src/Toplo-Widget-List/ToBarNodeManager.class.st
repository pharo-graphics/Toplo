Class {
	#name : #ToBarNodeManager,
	#superclass : #ToAbstractListNodeManager,
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToBarNodeManager >> constraintNode: aNode [

	| bar |
	bar := aNode holder listElement.
	aNode constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	bar nodeScrolling ifTrue: [ ^ self ].
	aNode autoDistribute: bar nodeAutoDistribution
]

{ #category : #initialization }
ToBarNodeManager >> defaultNodeBuilder [

	^ [ :node :holder :dataItem |
	  node addChild: (ToLabel text: dataItem asString) hMatchParent.
	  ]
]

{ #category : #initialization }
ToBarNodeManager >> defaultNodeFactory [

	^ [ :holder | ToBarNode new ]
]

{ #category : #initialization }
ToBarNodeManager >> defaultNodeHolderClass [

	^ ToBarNodeHolder
]

{ #category : #accessing }
ToBarNodeManager >> fakeDataItem [

	^ fakeDataItem
]

{ #category : #accessing }
ToBarNodeManager >> fakeDataItem: anObject [

	fakeDataItem := anObject
]

{ #category : #'instance creation' }
ToBarNodeManager >> newFakeNodeForHolder: anHolder [

	| fakeNode |
	fakeNode := self newNodeForHolder: anHolder.
	self buildNode: fakeNode inHolder: anHolder.
	self constraintNode: fakeNode.
	fakeNode constraintsDo: [ :c |
		fakeNode holder listElement isHorizontal
			ifTrue: [ c horizontal exact: 0 ]
			ifFalse: [ c vertical exact: 0 ] ].
	fakeNode margin: BlInsets empty.
	anHolder node: fakeNode.
	^ fakeNode
]
