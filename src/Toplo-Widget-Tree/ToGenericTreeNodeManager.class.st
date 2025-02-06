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

	nodeBuilder
		cull: aNode
		cull: aNode holder dataWrapper 
		cull: aNode holder
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultHolderClass [

	^ ToTreeNodeHolder
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeBuilder [

	^ [ :node :dataWrapper :holder |
	  | start |
	  start := self indentationDependingOnWrapper: dataWrapper.
	  start addEventHandlerOn: BlClickEvent do: [ :e |
		  e consume.
		  holder click.
		self treeElement notifyDataSourceChanged ].
	  node addChild: (ToTripletElement new
			   margin: (BlInsets left: 20 * (dataWrapper nodeDepth - 1));
			   startElement: start;
			   middleElement: (ToLabel text: dataWrapper dataItem asString);
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
ToGenericTreeNodeManager >> indentationDependingOnWrapper: aDataSourceWrapper [

	| icon |
	icon := Smalltalk ui icons iconNamed: (aDataSourceWrapper isLeaf
			         ifTrue: [ #glamorousGrayCircleEmpty ]
			         ifFalse: [
				         aDataSourceWrapper isCollapsed
					         ifTrue: [ #glamorousGrayCircle ]
					         ifFalse: [ #glamorousDropDown ] ]).
	

	^ ToElement new
		  size: 20 @ 20;
		  background: icon
]

{ #category : #accessing }
ToGenericTreeNodeManager >> treeElement [ 

	^ treeElement
]

{ #category : #accessing }
ToGenericTreeNodeManager >> treeElement: aTreeElement [

	treeElement := aTreeElement 
]
