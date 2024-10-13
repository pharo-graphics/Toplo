Class {
	#name : #ToTagNodeManager,
	#superclass : #ToBarNodeManager,
	#instVars : [
		'compositeNodeBuilder'
	],
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #'instance creation' }
ToTagNodeManager >> buildNode: aNode inHolder: aNodeHolder [

	aNodeHolder tagModel
		buildNode: aNode
		inHolder: aNodeHolder
		withManager: self
]

{ #category : #accessing }
ToTagNodeManager >> compositeNodeBuilder [

	" aValuable takes the node, then the compositeDataItem then the holder as arguments "
	^ compositeNodeBuilder 
]

{ #category : #accessing }
ToTagNodeManager >> compositeNodeBuilder: aValuable [

	" aValuable takes the node, then the compositeDataItem then the holder as arguments "
	compositeNodeBuilder := aValuable 
]

{ #category : #initialization }
ToTagNodeManager >> defaultCompositeNodeBuilder [

	^ [ :node :compositeTagModel :holder |
	  node addChild: (ToLabel text: compositeTagModel content asString) ]
]

{ #category : #initialization }
ToTagNodeManager >> defaultFakeDataItem [

	^ ToSingleTagModel new
]

{ #category : #initialization }
ToTagNodeManager >> defaultHolderClass [

	^ ToTagNodeHolder
]

{ #category : #initialization }
ToTagNodeManager >> defaultNodeBuilder [

	^ [ :node :tagModel :holder |
	  | tag |
	  tag := ToTagElement new
		         labelText: tagModel asString;
		         flexible: true;
		         hMatchParent.
	  tag removable: holder withCloseButton.
	  node addChild: tag.
	  tag constraintsDo: [ :c | c linear vertical alignCenter ] ]
]

{ #category : #initialization }
ToTagNodeManager >> defaultNodeFactory [

	^ [ :holder | ToTagNode new ]
]

{ #category : #initialization }
ToTagNodeManager >> initialize [ 

	super initialize.
	compositeNodeBuilder := self defaultCompositeNodeBuilder
]
