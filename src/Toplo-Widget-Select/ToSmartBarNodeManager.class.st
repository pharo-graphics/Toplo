Class {
	#name : #ToSmartBarNodeManager,
	#superclass : #ToBarNodeManager,
	#instVars : [
		'compositeNodeBuilder'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToSmartBarNodeManager >> buildNode: aNode inHolder: aNodeHolder [

	aNodeHolder dataItem
		buildNode: aNode
		inHolder: aNodeHolder
		withManager: self
]

{ #category : #accessing }
ToSmartBarNodeManager >> compositeNodeBuilder [

	" aValuable takes the node, then the compositeDataItem then the holder as arguments "
	^ compositeNodeBuilder 
]

{ #category : #accessing }
ToSmartBarNodeManager >> compositeNodeBuilder: aValuable [

	" aValuable takes the node, then the compositeDataItem then the holder as arguments "
	compositeNodeBuilder := aValuable 
]

{ #category : #initialization }
ToSmartBarNodeManager >> defaultCompositeNodeBuilder [

	^ [ :node :compositeDataItem :holder |
	  node addChild: (ToLabel text: compositeDataItem content asString) ]
]

{ #category : #initialization }
ToSmartBarNodeManager >> defaultFakeDataItem [

	^ ToBarFakeItem new
]

{ #category : #initialization }
ToSmartBarNodeManager >> defaultNodeBuilder [

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
ToSmartBarNodeManager >> defaultNodeFactory [

	^ [ :holder | ToSmartBarNode new ]
]

{ #category : #initialization }
ToSmartBarNodeManager >> initialize [ 

	super initialize.
	compositeNodeBuilder := self defaultCompositeNodeBuilder
]
