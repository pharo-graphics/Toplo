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

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultHolderClass [

	^ ToTreeNodeHolder
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
	  | start |
	  start := self transparentIndentationElement.
	  start addEventHandlerOn: BlClickEvent do: [ :e |
		  e consume.
		  holder click ].
	  node addChild: (ToTripletElement new
			   startElement: start;
			   middleElement: (ToLabel text: dataItem  asString);
			   startInterspace: 5) ]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeFactory [

	^ [ :holder |
	  ToTreeNode new nodeHolder: holder ]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeUnbuilder [

	^ [ :node :dataItem :holder | ]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> transparentIndentationElement [

	^ ToElement new
		  size: 20 @ 20;
		  background: Color random
]

{ #category : #accessing }
ToGenericTreeNodeManager >> treeElement [ 

	^ treeElement
]

{ #category : #accessing }
ToGenericTreeNodeManager >> treeElement: aTreeElement [

	treeElement := aTreeElement 
]
