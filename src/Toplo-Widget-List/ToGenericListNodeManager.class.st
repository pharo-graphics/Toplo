Class {
	#name : #ToGenericListNodeManager,
	#superclass : #ToAbstractNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToGenericListNodeManager >> constraintNode: aNode [

	aNode constraintsDo: [ :c |
		| l |
		l := aNode holder listElement.
		l isHorizontal
			ifTrue: [ c horizontal fitContent ]
			ifFalse: [ c horizontal matchParent ].
		c vertical fitContent ]
]

{ #category : #initialization }
ToGenericListNodeManager >> defaultHolderClass [

	^ ToListNodeHolder
]

{ #category : #initialization }
ToGenericListNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
	  node addChild: (ToLabel text: dataItem asString)  ]
]

{ #category : #initialization }
ToGenericListNodeManager >> defaultNodeFactory [

	^ [ :holder | ToListNode new ]
]

{ #category : #initialization }
ToGenericListNodeManager >> defaultNodeUnbuilder [

	^ [ :node :dataItem :holder | ]
]

{ #category : #initialization }
ToGenericListNodeManager >> initialize [

	super initialize.
	holderClass := self defaultHolderClass.
	nodeBuilder := self defaultNodeBuilder.
	nodeUnbuilder := self defaultNodeUnbuilder.
	nodeFactory := self defaultNodeFactory
]
