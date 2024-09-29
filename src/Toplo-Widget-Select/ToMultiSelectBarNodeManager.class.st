Class {
	#name : #ToMultiSelectBarNodeManager,
	#superclass : #ToBarNodeManager,
	#instVars : [
		'compositeNodeBuilder'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToMultiSelectBarNodeManager >> buildNode: aNode inHolder: aNodeHolder [

	aNodeHolder dataItem
		buildNode: aNode
		inHolder: aNodeHolder
		withManager: self
]

{ #category : #accessing }
ToMultiSelectBarNodeManager >> compositeNodeBuilder [

	" aValuable takes the node, then the compositeDataItem then the holder as arguments "
	^ compositeNodeBuilder 
]

{ #category : #accessing }
ToMultiSelectBarNodeManager >> compositeNodeBuilder: aValuable [

	" aValuable takes the node, then the compositeDataItem then the holder as arguments "
	compositeNodeBuilder := aValuable 
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultCompositeNodeBuilder [

	^ [ :node :compositeDataItem :holder |
	  node addChild:
		  (ToLabel text: compositeDataItem content asString) ]
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultFakeDataItem [

	^ ToMultiSelectItem index: 0
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultHolderClass [ 

	^ ToMultiSelectNodeHolder
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
	  | tag |
	  tag := ToTagElement new
		         labelText: dataItem asString;
		         flexible: true;
		         hMatchParent.
	  node addChild: tag.
	  tag constraintsDo: [ :c | c linear vertical alignCenter ] ]
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultNodeFactory [

	^ [ :holder | ToMultiSelectBarNode new ]
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> initialize [ 

	super initialize.
	compositeNodeBuilder := self defaultCompositeNodeBuilder
]
