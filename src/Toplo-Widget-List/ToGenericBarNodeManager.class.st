Class {
	#name : #ToGenericBarNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#instVars : [
		'fakeDataItem'
	],
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #initialization }
ToGenericBarNodeManager >> constraintNode: aNode [

	| bar |
	bar := aNode holder listElement.
	aNode constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	bar nodeScrolling ifTrue: [ ^ self ].
	aNode autoDistribute: bar nodeAutoDistribution
]

{ #category : #initialization }
ToGenericBarNodeManager >> defaultFakeDataItem [

	^ nil
]

{ #category : #initialization }
ToGenericBarNodeManager >> defaultHolderClass [

	^ ToListNodeHolder
]

{ #category : #initialization }
ToGenericBarNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
	  node addChild: (ToLabel text: dataItem asString)  ]
]

{ #category : #initialization }
ToGenericBarNodeManager >> defaultNodeFactory [

	^ [ :holder | ToListNode new ]
]

{ #category : #initialization }
ToGenericBarNodeManager >> defaultNodeUnbuilder [

	^ [ :node :dataItem :holder | ]
]

{ #category : #accessing }
ToGenericBarNodeManager >> fakeDataItem [

	^ fakeDataItem
]

{ #category : #accessing }
ToGenericBarNodeManager >> fakeDataItem: anObject [

	fakeDataItem := anObject
]

{ #category : #initialization }
ToGenericBarNodeManager >> initialize [ 

	super initialize.
		holderClass := self defaultHolderClass.
	nodeBuilder := self defaultNodeBuilder.
	nodeUnbuilder := self defaultNodeUnbuilder.
	nodeFactory := self defaultNodeFactory.
	fakeDataItem := self defaultFakeDataItem 
]
