Class {
	#name : #ToTreeNodeManager,
	#superclass : #ToWrappedListNodeManager,
	#instVars : [
		'lazilyComputeChildren'
	],
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

{ #category : #accessing }
ToTreeNodeManager >> lazilyComputeChildren: aBoolean [
	"When true, the children of a data item are only computed when its node is expanded.
	Until then, the node is considered as possibly having children and shows its expand arrow."

	lazilyComputeChildren := aBoolean
]

{ #category : #testing }
ToTreeNodeManager >> shouldLazilyComputeChildren [

	^ lazilyComputeChildren ifNil: [ false ]
]
