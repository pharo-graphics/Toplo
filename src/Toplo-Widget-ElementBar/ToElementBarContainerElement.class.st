Class {
	#name : #ToElementBarContainerElement,
	#superclass : #ToElement,
	#instVars : [
		'fakeNode',
		'fakeDataItem',
		'elementBar',
		'nodeWrapping',
		'nodeScrolling',
		'nodeAutoDistribution',
		'innerNodeContainer',
		'scrollable',
		'nodeHolders',
		'previousMeasuredBarWidth'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #adding }
ToElementBarContainerElement >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #adding }
ToElementBarContainerElement >> addDataNode: aNode [

	elementBar nodeAutoDistribution ifTrue: [ aNode autoDistribute ].
	innerNodeContainer addChild: aNode before: fakeNode
]

{ #category : #adding }
ToElementBarContainerElement >> addFakeNode [

	innerNodeContainer addChild: fakeNode
]

{ #category : #layout }
ToElementBarContainerElement >> checkVisibleNodes [

	| invisibleNodes currentHeaderWidth |
	self ensurePreviousMeasuredBarWidth.
	currentHeaderWidth := self measuredWidth.
	currentHeaderWidth > previousMeasuredBarWidth ifTrue: [
		previousMeasuredBarWidth := currentHeaderWidth.
		self enqueueTask: (BlTaskAction new action: [ self refresh ]).
		^ self ].
	(self nodeHolders size = 1 and: [
		 self nodeHolders first nodesCount > 1 ]) ifTrue: [ ^ self ].

	previousMeasuredBarWidth := currentHeaderWidth.
	invisibleNodes := self nodesSelect: [ :n |
		                  n isFullyVisible not ].
	invisibleNodes ifEmpty: [ ^ self ].
	self haveInvisibleNodes: invisibleNodes
]

{ #category : #initialization }
ToElementBarContainerElement >> defaultNodeClass [

	^ ToElementBarNode
]

{ #category : #accessing }
ToElementBarContainerElement >> elementBar [

	^ elementBar
]

{ #category : #layout }
ToElementBarContainerElement >> ensurePreviousMeasuredBarWidth [

	previousMeasuredBarWidth ifNil: [
		previousMeasuredBarWidth := self measuredWidth  ]
]

{ #category : #accessing }
ToElementBarContainerElement >> fakeDataItem: aData [

	fakeDataItem := aData.
	self installFakeNode 
]

{ #category : #layout }
ToElementBarContainerElement >> haveInvisibleNodes: invisibleNodes [
]

{ #category : #initialization }
ToElementBarContainerElement >> initialize [

	super initialize.
	nodeWrapping := true.
	nodeScrolling := false

]

{ #category : #initialization }
ToElementBarContainerElement >> installFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."
 
	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].

	fakeNode := self newNode.
	fakeNode id: #fakeNode.
	fakeNode holder dataItem: fakeDataItem.
	self nodeBuilder value: fakeNode value: fakeNode holder.
	fakeNode width: 0.
	fakeNode margin: BlInsets empty.
	fakeNode constraintsDo: [ :c |
		c flow vertical alignCenter.
		c linear vertical alignCenter ].
	" add the fake node (to keep a constant minimum height )"
	self addFakeNode
]

{ #category : #initialization }
ToElementBarContainerElement >> newNode [

	| node nodeHolder |
	node := self nodeClass new.
	nodeHolder := self newNodeHolder.
	node holder: nodeHolder.
	nodeHolder
		node: node;
		position: 0;
		elementBar: elementBar;
		dataItem: nil.
	node onInstalledIn: self.
		
	^ node
]

{ #category : #initialization }
ToElementBarContainerElement >> newNodeHolder [

	^ self nodeHolderClass new elementBar: elementBar; yourself
]

{ #category : #accessing }
ToElementBarContainerElement >> nodeAutoDistribution [

	^ nodeAutoDistribution
]

{ #category : #accessing }
ToElementBarContainerElement >> nodeAutoDistribution: aBoolean [

	nodeAutoDistribution := aBoolean.
	self onNodeDistributionChange
]

{ #category : #accessing }
ToElementBarContainerElement >> nodeBuilder [
	
	" return a valuable that is used to build a bar node element from a data. 
	aValuable take the bar node element to build as first argument 
	and its holder as second argument"

	^ [ :aBarNode :aNodeHolder |
	  aBarNode middleContainer addChild:
		  (ToLabel text: aNodeHolder dataItem asString) ]
]

{ #category : #accessing }
ToElementBarContainerElement >> nodeClass [ 

	^ self defaultNodeClass
]

{ #category : #initialization }
ToElementBarContainerElement >> nodeHolderClass [ 

	^ ToElementBarNodeHolder
]

{ #category : #accessing }
ToElementBarContainerElement >> nodeHolders [

	^ nodeHolders ifNil: [
		  nodeHolders := OrderedCollection new ]
]

{ #category : #accessing }
ToElementBarContainerElement >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean.
	self onNodeScrollingChange  
]

{ #category : #accessing }
ToElementBarContainerElement >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	self onNodeWrappingChange  
]

{ #category : #accessing }
ToElementBarContainerElement >> nodes [

	^ self nodeHolders collect: [ :h | h node ]

]

{ #category : #accessing }
ToElementBarContainerElement >> nodesCount [

	| count |
	count := 0.
	self nodeHolders do: [ :nodeHolder |
		count := count + nodeHolder nodesCount ].
	^ count
]

{ #category : #enumerating }
ToElementBarContainerElement >> nodesDo: aBlock [

	self nodeHolders do: [ :nodeHolder |	aBlock value: nodeHolder node ].
]

{ #category : #enumerating }
ToElementBarContainerElement >> nodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodeHolders do: [ :nodeHolder |
			  (aBlock value: nodeHolder node) ifTrue: [
				  stream nextPut: nodeHolder node ] ] ]
]

{ #category : #'api - hooks' }
ToElementBarContainerElement >> onInstalledIn: anElementBar [

	elementBar := anElementBar.

	self layout: BlLinearLayout horizontal.
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].

	innerNodeContainer := ToElement new.
	innerNodeContainer layout: (nodeWrapping
			 ifTrue: [ BlFlowLayout horizontal ]
			 ifFalse: [ BlLinearLayout horizontal ]).

	innerNodeContainer constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter.
		c vertical fitContent ].
	
	self onNodeWrappingChange.
	self onNodeScrollingChange.

	scrollable := innerNodeContainer asScrollableElement.
	scrollable constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter.
		c vertical fitContent.
		c horizontal matchParent ].

	" The textField is added whatever the mode to draw the placeholder text if any.
	In case of read-only mode, the textfield is set as read-only by the mode "
	self addChild: scrollable.
	self installFakeNode
]

{ #category : #layout }
ToElementBarContainerElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	nodeWrapping ifTrue: [ ^ self ].
	nodeScrolling ifTrue: [ ^ self ].
	self checkVisibleNodes
]

{ #category : #accessing }
ToElementBarContainerElement >> onNodeDistributionChange [

	nodeScrolling ifTrue: [ ^ self ].
	nodeAutoDistribution ifTrue: [
		self nodesDo: [ :n | n autoDistribute ] ]
]

{ #category : #accessing }
ToElementBarContainerElement >> onNodeScrollingChange [

	innerNodeContainer ifNil: [ ^ self ].
	nodeScrolling
		ifTrue: [
		innerNodeContainer constraintsDo: [ :c | c horizontal fitContent ] ]
		ifFalse: [
		innerNodeContainer constraintsDo: [ :c | c horizontal matchParent ] ]
]

{ #category : #accessing }
ToElementBarContainerElement >> onNodeWrappingChange [

	innerNodeContainer ifNil: [ ^ self ].
	innerNodeContainer layout: (nodeWrapping
			 ifTrue: [ BlFlowLayout horizontal ]
			 ifFalse: [ BlLinearLayout horizontal ])
]

{ #category : #'api - hooks' }
ToElementBarContainerElement >> onUninstalledIn: anElementBar [

	self nodesDo: [ :node |
		node onUninstalledIn: anElementBar.
		node removeFromParent ].
	self nodeHolders reset.
	fakeNode ifNotNil: [ 
		fakeNode onUninstalledIn: anElementBar.
		fakeNode removeFromParent.
		fakeNode := nil ].
	innerNodeContainer removeFromParent.
	innerNodeContainer := nil.
	elementBar := nil
]

{ #category : #window }
ToElementBarContainerElement >> onWindowClosed [

	self textInputElement onWindowClosed
]

{ #category : #window }
ToElementBarContainerElement >> onWindowOpened [

	self textInputElement onWindowOpened
]

{ #category : #accessing }
ToElementBarContainerElement >> refresh [

	self subclassResponsibility 
]

{ #category : #accessing }
ToElementBarContainerElement >> selectedDataTextField [

	^ self textInputElement selectedDataTextField
]
