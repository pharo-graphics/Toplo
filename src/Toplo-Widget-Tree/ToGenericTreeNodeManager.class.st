Class {
	#name : #ToGenericTreeNodeManager,
	#superclass : #ToGenericListNodeManager,
	#instVars : [
		'nodeWrapperClass',
		'treeElement'
	],
	#category : #'Toplo-Widget-Tree'
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
			   middleElement: (ToLabel text: dataItem asString);
			   startInterspace: 5) ]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeFactory [

	^ [ :holder |
	  holder wrapper: self defaultNodeWrapperClass new.
	  holder treeElement: self treeElement.
	  ToTreeNode new nodeHolder: holder ]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeUnbuilder [

	^ [ :node :dataItem :holder | ]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeWrapperClass [ 

	^ ToTreeClassWrapper
]

{ #category : #initialization }
ToGenericTreeNodeManager >> initialize [ 

	super initialize.
	nodeWrapperClass := self defaultNodeWrapperClass 
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
