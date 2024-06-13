Class {
	#name : #ToBarNodeManager,
	#superclass : #ToAbstractListNodeManager,
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core'
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
