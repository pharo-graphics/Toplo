Class {
	#name : #ToMultiSelectBarNodeManager,
	#superclass : #ToBarNodeManager,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToMultiSelectBarNodeManager >> buildFakeNode: aFakeNode inHolder: anHolder [

	" The fake data item is always store in node with holder which position is zero "
	anHolder dataItem: (ToMultiSelectItem index: 0).
	super buildFakeNode: aFakeNode inHolder: anHolder
]

{ #category : #'instance creation' }
ToMultiSelectBarNodeManager >> buildNode: aNode inHolder: aNodeHolder [

	| multiSelectDataItem |
	multiSelectDataItem := aNodeHolder dataItem.
	multiSelectDataItem isComposite
		ifFalse: [
			| index data |
			index := multiSelectDataItem index.
			data := index isZero
				        ifTrue: [ self fakeDataItem ]
				        ifFalse: [ aNodeHolder dataAccessor at: index ].
			nodeBuilder value: aNode value: data value: aNodeHolder.
			aNode addEventHandlerOn: ToInnerElementRemovedEvent do: [ :event |
				event consume.
				aNode removeFromBar ] ]
		ifTrue: [
			self defaultCompositeNodeBuilder
				value: aNode
				value: multiSelectDataItem
				value: aNodeHolder ]
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultCompositeNodeBuilder [

	^ [ :node :compositeDataItem :holder |
	  node addChild:
		  (ToLabel text: compositeDataItem content asString asRopedText) ]
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
ToMultiSelectBarNodeManager >> defaultNodeHolderClass [ 

	^ ToMultiSelectBarNodeHolder
]
