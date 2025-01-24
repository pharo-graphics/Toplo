Class {
	#name : #ToGenericTreeNodeManager,
	#superclass : #ToGenericListNodeManager,
	#category : #'Toplo-Widget-Tree'
}

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultHolderClass [

	^ ToTreeNodeHolder
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
	  node addChild: 
		(ToTripletElement new
		startElement: self transparentIndentationElement;
			middleElement: (ToLabel text: dataItem asString))  ]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeFactory [

	^ [ :holder | ToTreeNode new nodeHolder: holder]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeUnbuilder [

	^ [ :node :dataItem :holder | ]
]

{ #category : #'as yet unclassified' }
ToGenericTreeNodeManager >> transparentIndentationElement [ 

	^ ToElement new size: 15@1.
]
