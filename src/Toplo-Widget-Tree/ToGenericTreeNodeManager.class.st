"
I am a ToGenericTreeNodeManager

I hold the logic of building and destroying NodeHolders and TreeNodes whenever the DataSource is updated
"
Class {
	#name : #ToGenericTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#instVars : [
		'childrenGetter'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - generic node manager' }
ToGenericTreeNodeManager >> buildNode: aTreeNode [

	| content |
	checkableNode ifTrue: [
			| listElement checkElement |
			listElement := aTreeNode holder listElement.
			checkElement := ToElement new
				                hFitContent;
				                vFitContent;
				                yourself.
			listElement newCheckableElementIn: checkElement inNode: aTreeNode.
			aTreeNode addChild: checkElement at: 1 ].
	content := ToElement new
		           hMatchParent;
		           vFitContent;
		           yourself.
	aTreeNode content middleElement: content.
	nodeBuilder
		cull: content
		cull: aTreeNode holder treeDataItem
		cull: aTreeNode holder.
	aTreeNode childrenDo: [ :child |
		child constraintsDo: [ :c | c linear vertical alignCenter ] ]
]

{ #category : #'children accessing' }
ToGenericTreeNodeManager >> childrenFromDataItem: aDataItem [

	^ (childrenGetter value: aDataItem) asArray
]

{ #category : #accessing }
ToGenericTreeNodeManager >> childrenGetter: aValuable [

	childrenGetter := aValuable
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultChildrenGetter [

	^ [ :dataItem | #(  ) ]
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
	childrenGetter := self defaultChildrenGetter 
]

{ #category : #'t - generic node manager' }
ToGenericTreeNodeManager >> newHolder [

	^ super newHolder
]
