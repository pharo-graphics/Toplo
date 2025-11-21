"
I am a ToGenericTreeNodeManager

I hold the logic of building and destroying NodeHolders and TreeNodes whenever the DataSource is updated
"
Class {
	#name : #ToGenericTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#traits : 'TToGenericNodeManager + TToGenericTreeNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait + TToGenericTreeNodeManager classTrait',
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'node building' }
ToGenericTreeNodeManager >> buildNode: aTreeNode [

	| content |
	
	checkableNode ifTrue: [
			| listElement cbox |
			listElement := aTreeNode holder listElement.
			cbox := listElement newCheckboxInNode: aTreeNode.
			cbox constraintsDo: [ :c | c linear vertical alignCenter ].
			aTreeNode addChild: cbox at: 1 ].

	aTreeNode initializeStartElement.
	content := ToElement new
		           hMatchParent;
		           vFitContent;
		           yourself.
	aTreeNode middleElement: content.
	nodeBuilder
		cull: content
		cull: aTreeNode holder treeDataItem
		cull: aTreeNode holder.
	aTreeNode childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ]
]

{ #category : #'t - generic node manager' }
ToGenericTreeNodeManager >> defaultNodeFactory [

	^ [ :holder |
	  ToTreeNode new ]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager.
	self initializeAsGenericTreeNodeManager
]

{ #category : #'t - generic node manager' }
ToGenericTreeNodeManager >> newHolder [

	^ super newHolder
]
