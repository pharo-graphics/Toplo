Class {
	#name : #ToGenericBarNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - generic node manager' }
ToGenericBarNodeManager >> buildNode: aNode [

	nodeBuilder
		cull: aNode
		cull: aNode holder dataItem
		cull: aNode holder
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

	^ [ :holder | ToBarNode new ]
]

{ #category : #initialization }
ToGenericBarNodeManager >> defaultNodeUnbuilder [

	^ [ :node :dataItem :holder | ]
]

{ #category : #initialization }
ToGenericBarNodeManager >> initialize [ 

	super initialize.
		holderClass := self defaultHolderClass.
	nodeBuilder := self defaultNodeBuilder.
	nodeUnbuilder := self defaultNodeUnbuilder.
	nodeFactory := self defaultNodeFactory
]
