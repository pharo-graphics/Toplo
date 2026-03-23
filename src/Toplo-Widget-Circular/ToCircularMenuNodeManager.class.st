Class {
	#name : #ToCircularMenuNodeManager,
	#superclass : #Object,
	#traits : 'TToListNodeManager',
	#classTraits : 'TToListNodeManager classTrait',
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #'t - list node manager' }
ToCircularMenuNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: holder dataItem
]

{ #category : #'t - list node manager' }
ToCircularMenuNodeManager >> buildNodeContainer: aNodeContainer [

	aNodeContainer addChild: aNodeContainer node
]

{ #category : #'t - list node manager' }
ToCircularMenuNodeManager >> defaultNodeContainerFactory [

	^ [ ToCircularMenuNodeContainer new ]
]

{ #category : #'t - list node manager' }
ToCircularMenuNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToCircularMenuNode new ]
]

{ #category : #'t - list node manager' }
ToCircularMenuNodeManager >> defaultNodeHolderFactory [

	^ [ ToItemNodeHolder new ]
]

{ #category : #initialization }
ToCircularMenuNodeManager >> initialize [ 

	super initialize.
	self initializeAsListNodeManager 

]

{ #category : #'t - list node manager' }
ToCircularMenuNodeManager >> unbuildNode: aNode [

	aNode item removeFromParent
]
