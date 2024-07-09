Class {
	#name : #ToMultiSelectBarNodeManager,
	#superclass : #ToBarNodeManager,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'instance creation' }
ToMultiSelectBarNodeManager >> buildFakeNode: aFakeNode inHolder: anHolder [

	" The fake data item is always store in node with holder which position is zero "
	anHolder dataItem: (ToMultiSelectDataItem index: 0).
	super buildFakeNode: aFakeNode inHolder: anHolder
]

{ #category : #initialization }
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
			nodeBuilder value: aNode value: aNodeHolder value: data ]
		ifTrue: [
			self defaultCompositeNodeBuilder
				value: aNode
				value: aNodeHolder
				value: multiSelectDataItem ]
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultCompositeNodeBuilder [

	^ [ :node :holder :compositeDataItem |
	  node middleElement:
		  (ToLabel text: compositeDataItem content asString asRopedText) ]
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultNodeBuilder [

	^ [ :node :holder :dataItem |
	  node middleElement: (ToLabel text: dataItem asString) ]
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultNodeFactory [

	^ [ :holder | ToMultiSelectBarNode new ]
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultNodeHolderClass [ 

	^ ToMultiSelectBarNodeHolder
]

{ #category : #initialization }
ToMultiSelectBarNodeManager >> defaultStandardNodeBuilder [

	^ [ :node :holder :dataItem |
	  node middleElement: (ToLabel text: dataItem asString) ]
]
