Class {
	#name : #ToTreeNodeManager,
	#superclass : #ToWrappedListNodeManager,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #initialization }
ToTreeNodeManager >> buildNodeContainer: aTreeNodeContainer [

	super buildNodeContainer: aTreeNodeContainer.
	aTreeNodeContainer buildStartContainer
]

{ #category : #'children accessing' }
ToTreeNodeManager >> childrenFromDataItem: aDataItem [

	^ #(  )
]

{ #category : #initialization }
ToTreeNodeManager >> defaultNodeContainerFactory [

	^ [ ToTreeNodeContainer new ]
]

{ #category : #initialization }
ToTreeNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToTreeNode new ]
]
