"
I have the responsibility to build the nodeContainers, the nodeHolders and the nodes.
For each data item I create a nodeContainer, its node and the holder that relates the data, the list, and the nodeContainer.  
"
Class {
	#name : #ToBasicListNodeManager,
	#superclass : #Object,
	#instVars : [
		'checkableNode',
		'nodeContainerFactory',
		'nodeHolderFactory',
		'nodeFactory',
		'isBuildingFakeNodeContainer'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToBasicListNodeManager >> buildNode: aNode [ 

	
]

{ #category : #initialization }
ToBasicListNodeManager >> buildNodeContainer: aNodeContainer [

	| listElement cbox |
	listElement := aNodeContainer holder listElement.
	checkableNode ifFalse: [ ^ self ].
	cbox := listElement newCheckboxInNodeContainer: aNodeContainer.
	cbox constraintsDo: [ :c | c linear vertical alignCenter ].
	aNodeContainer ensureStartContainer.
	aNodeContainer startContainer addChild: cbox.
	
]

{ #category : #accessing }
ToBasicListNodeManager >> checkableNode [

	^ checkableNode
]

{ #category : #accessing }
ToBasicListNodeManager >> checkableNode: aBoolean [

	checkableNode := aBoolean 
]

{ #category : #'fake node container' }
ToBasicListNodeManager >> createFakeNodeContainerIn: aListElement [

	| wrapper holder |
	wrapper := ToFakeNodeContainerWrapper new.
	holder := self newHolder.
	holder infiniteElement: aListElement innerElement.
	holder fakeDataItem: aListElement fakeDataItem.
	holder bindAtPosition: 0.
	" assigning the holder builds the middleContainer (which is the node of the fake node container) "
	wrapper holder: holder.
	wrapper nodeContainer: self newNodeContainer.
	wrapper nodeContainer id: #fakeNodeContainerWrapper.
	wrapper nodeContainer holder: holder.
	wrapper node holder: holder.
	wrapper node id: #fakeNode.
	holder setupNodeContainerWith: wrapper.
	" add the fake node (to keep a constant minimum size ).
	Pay attention to add the fake node ** before ** the fake node building "
	[ self buildNodeContainer: wrapper nodeContainer ]
		on: Error
		do: [ :error |
				'*** Warning: can''t build the fake node container: ' trace.
				error traceCr ].
	[ self buildNode: wrapper node ]
		on: Error
		do: [ :error |
				'*** Warning: can''t build the fake node: ' trace.
				error traceCr ].
	^ wrapper
]

{ #category : #initialization }
ToBasicListNodeManager >> defaultNodeContainerFactory [

	^ [ ToNodeContainer new ]
]

{ #category : #initialization }
ToBasicListNodeManager >> defaultNodeFactory [

	^ [ :holder | ToBasicListNode new ]
]

{ #category : #initialization }
ToBasicListNodeManager >> defaultNodeHolderFactory [

	^ [ ToNodeHolder new ]
]

{ #category : #'fake node container' }
ToBasicListNodeManager >> flagAsBuildingFakeNodeContainerWhile: aBlock [

	isBuildingFakeNodeContainer := true.
	aBlock ensure: [ isBuildingFakeNodeContainer := false ]
]

{ #category : #initialization }
ToBasicListNodeManager >> initialize [ 

	super initialize.
	checkableNode := false.
	nodeContainerFactory := self defaultNodeContainerFactory.
	nodeFactory := self defaultNodeFactory.
	nodeHolderFactory := self defaultNodeHolderFactory
]

{ #category : #'fake node container' }
ToBasicListNodeManager >> isBuildingFakeNodeContainer [

	^ isBuildingFakeNodeContainer ifNil: [
		  isBuildingFakeNodeContainer := false ]
]

{ #category : #'fake node container' }
ToBasicListNodeManager >> newFakeNodeContainerIn: aListElement [

	self flagAsBuildingFakeNodeContainerWhile: [
		^ self createFakeNodeContainerIn: aListElement ]
]

{ #category : #'instance creation' }
ToBasicListNodeManager >> newHolder [

	^ nodeHolderFactory value
]

{ #category : #'instance creation' }
ToBasicListNodeManager >> newNodeContainer [ 

	^ nodeContainerFactory value
]

{ #category : #'instance creation' }
ToBasicListNodeManager >> newNodeForHolder: aNodeHolder [

	^ nodeFactory cull: aNodeHolder
]

{ #category : #'instance creation' }
ToBasicListNodeManager >> nodeContainerFactory: aValuable [
	" aValuable that takes no argument an return a new node container "

	nodeContainerFactory := aValuable
]

{ #category : #'instance creation' }
ToBasicListNodeManager >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	nodeFactory := aValuable
]

{ #category : #'instance creation' }
ToBasicListNodeManager >> nodeHolderFactory: aValuable [
	" aValuable that takes no argument an return a new holder "

	nodeHolderFactory := aValuable
]

{ #category : #'fake node container' }
ToBasicListNodeManager >> refreshFakeNodeContainer: aFakeNodeContainerWrapper [

	| holder |
	[ self unbuildNode: aFakeNodeContainerWrapper node ]
		on: Error
		do: [ :error |
				'*** Warning: can''t unbuild the fake node: ' trace.
				error traceCr ].
	holder := aFakeNodeContainerWrapper holder.
	holder dataItem: holder listElement fakeDataItem.
	" add the fake node (to keep a constant minimum size ).
	Pay attention to add the fake node ** before ** the fake node building "
	[ self buildNode: aFakeNodeContainerWrapper node ]
		on: Error
		do: [ :error |
				'*** Warning: can''t rebuild the fake node: ' trace.
				error traceCr ]
]

{ #category : #initialization }
ToBasicListNodeManager >> unbuildNode: aNode [


]
