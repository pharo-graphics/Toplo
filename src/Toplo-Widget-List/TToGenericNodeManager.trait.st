Trait {
	#name : #TToGenericNodeManager,
	#instVars : [
		'nodeHolderFactory',
		'nodeFactory',
		'nodeBuilder',
		'nodeUnbuilder',
		'checkableNode'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> buildCheckableNode: aNode [

	| part cbox |
	cbox := ToCheckbox new.
	cbox focusability: BlFocusability none.
	cbox checked: aNode holder isSelected.
	cbox
		addEventHandlerOn: ToCheckableCheckEvent
		do: [ :event | aNode holder selected: event checked ].
	aNode addChild: cbox.
	part := ToElement new
		        hMatchParent;
		        vFitContent.
	part layout: BlLinearLayout horizontal.
	cbox constraintsDo: [ :c | c linear vertical alignCenter ].
	part constraintsDo: [ :c | c linear vertical alignCenter ].
	aNode addChild: part.
	nodeBuilder cull: part cull: aNode holder dataItem cull: aNode holder
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> buildNode: aNode [

	checkableNode ifTrue: [ ^ self buildCheckableNode: aNode ].
	self buildSimpleNode: aNode
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> buildSimpleNode: aNode [

	
	nodeBuilder cull: aNode cull: aNode holder dataItem cull: aNode holder
	
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> checkableNode: aBoolean [

	checkableNode := aBoolean
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
	  node addChild: (ToLabel text: dataItem asString)  ]
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> defaultNodeFactory [

	^ [ :holder | ToListNode new ]
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> defaultNodeHolderFactory [

	^ [ ToNodeHolder new ]
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> defaultNodeUnbuilder [

	^ [ :node :dataItem :holder |  ]
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> initializeAsGenericNodeManager [

	nodeBuilder := self defaultNodeBuilder.
	nodeUnbuilder := self defaultNodeUnbuilder.
	nodeFactory := self defaultNodeFactory.
	nodeHolderFactory := self defaultNodeHolderFactory.
	checkableNode := false
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> newHolder [

	^ nodeHolderFactory value
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> newNodeForHolder: aNodeHolder [

	^ nodeFactory cull: aNodeHolder
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	nodeBuilder := aValuable
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	nodeFactory := aValuable
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> nodeHolderFactory: aValuable [
	" aValuable that takes no argument an return a new holder "

	nodeHolderFactory := aValuable
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> nodeUnbuilder: aValuable [

	"aValuable takes 3 args: first, the node to build, second, the dataItem and third the holder in the list element "
	nodeUnbuilder := aValuable
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> unbuildNode: aNode [

	nodeUnbuilder cull: aNode cull: aNode holder dataItem cull: aNode holder

]
