"
I am a ToGenericTreeNodeManager

I hold the logic of building and destroying NodeHolders and TreeNodes whenever the DataSource is updated
"
Class {
	#name : #ToGenericTreeNodeManager,
	#superclass : #ToGenericListNodeManager,
	#instVars : [
		'treeElement'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - generic node manager' }
ToGenericTreeNodeManager >> buildNode: aNode [

	| wrapper |
	wrapper := aNode holder dataWrapper.
	"wrapper wrapChildren."

	nodeBuilder cull: aNode cull: wrapper cull: aNode holder
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultHolderClass [

	^ ToTreeNodeHolder
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeBuilder [

	^ [ :node :dataWrapper :holder |

	  node addChild: (ToTripletElement new
			   middleElement: (ToLabel text: dataWrapper dataItem asString);
			   startInterspace: 5) ]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeFactory [

	^ [ :holder |
	  ToTreeNode new ]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeUnbuilder [

	^ [ :node :dataItem :holder | ]
]
