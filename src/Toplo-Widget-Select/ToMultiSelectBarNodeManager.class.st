Class {
	#name : #ToMultiSelectBarNodeManager,
	#superclass : #ToBarNodeManager,
	#instVars : [
		'compositeNodeBuilder'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToMultiSelectBarNodeManager >> buildFakeNode: aFakeNode inHolder: anHolder [

	" The fake data item is always store in node with an holder for position zero "
	anHolder dataItem: (ToMultiSelectItem index: 0).
	super buildFakeNode: aFakeNode inHolder: anHolder
]

{ #category : #'instance creation' }
ToMultiSelectBarNodeManager >> buildNode: aNode inHolder: aNodeHolder [

	| multiSelectDataItem |
	aNodeHolder node: aNode.
	multiSelectDataItem := aNodeHolder dataItem.
	" an holder can have a composite data item if not wraping and not scrolling "
	multiSelectDataItem isComposite
		ifFalse: [
			| index data |
			index := multiSelectDataItem index.
			data := index isZero
				        ifTrue: [ fakeDataItem ]
				        ifFalse: [ aNodeHolder dataAccessor at: index ].
			nodeBuilder value: aNode value: data value: aNodeHolder.
			aNode addEventHandlerOn: ToInnerElementRemovedEvent do: [ :event |
				event consume.
				aNode removeFromBar ] ]
		ifTrue: [
			compositeNodeBuilder
				value: aNode
				value: multiSelectDataItem
				value: aNodeHolder ]
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
