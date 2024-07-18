Class {
	#name : #ToBarNodeManager,
	#superclass : #ToAbstractListNodeManager,
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'instance creation' }
ToBarNodeManager >> buildFakeNode: aFakeNode inHolder: anHolder [

	self buildNode: aFakeNode inHolder: anHolder.
	self constraintNode: aFakeNode.
	aFakeNode constraintsDo: [ :c |
		aFakeNode holder listElement isHorizontal
			ifTrue: [ c horizontal exact: 0 ]
			ifFalse: [ c vertical exact: 0 ] ].
	aFakeNode margin: BlInsets empty.
	anHolder node: aFakeNode
]

{ #category : #initialization }
ToBarNodeManager >> constraintFakeNode: aNode [

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
ToBarNodeManager >> constraintNode: aNode [

	| bar |
	aNode isFake ifTrue: [ ^ self ].
	bar := aNode holder barElement.
	aNode constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	bar nodeScrolling ifTrue: [ ^ self ].
	aNode autoDistribute: bar nodeAutoDistribution
]

{ #category : #initialization }
ToBarNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
	  node addChild: (ToLabel text: dataItem asString) hMatchParent ]
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
