Class {
	#name : #ToNodeBarContainerElement,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'fakeNode',
		'fakeDataItem',
		'elementBar',
		'innerNodeContainer',
		'previousMeasuredBarWidth',
		'nodeWrapping',
		'nodeScrolling',
		'nodeAutoDistribution',
		'scrollable',
		'nodeHolders'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #adding }
ToNodeBarContainerElement >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #adding }
ToNodeBarContainerElement >> addDataNode: aNode [

	elementBar nodeAutoDistribution ifTrue: [ aNode autoDistribute ].
	innerNodeContainer addChild: aNode before: fakeNode
]

{ #category : #adding }
ToNodeBarContainerElement >> addFakeNode [

	innerNodeContainer addChild: fakeNode
]

{ #category : #layout }
ToNodeBarContainerElement >> checkVisibleNodes [

	| invisibleNodes currentHeaderWidth |
	self ensurePreviousMeasuredBarWidth.
	currentHeaderWidth := self measuredWidth.
	currentHeaderWidth > previousMeasuredBarWidth ifTrue: [
		previousMeasuredBarWidth := currentHeaderWidth.
		self enqueueTask: (BlTaskAction new action: [ self refresh ]).
		^ self ].
	previousMeasuredBarWidth := currentHeaderWidth.
	invisibleNodes := self nodesSelect: [ :n | n isFullyVisible not ].
	invisibleNodes ifEmpty: [ ^ self ].
	self haveInvisibleNodes: invisibleNodes
]

{ #category : #initialization }
ToNodeBarContainerElement >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : #initialization }
ToNodeBarContainerElement >> defaultNodeClass [

	^ ToElementBarNode
]

{ #category : #accessing }
ToNodeBarContainerElement >> elementBar [

	^ elementBar
]

{ #category : #layout }
ToNodeBarContainerElement >> ensurePreviousMeasuredBarWidth [

	previousMeasuredBarWidth ifNil: [
		previousMeasuredBarWidth := self measuredWidth  ]
]

{ #category : #accessing }
ToNodeBarContainerElement >> fakeDataItem: aData [

	fakeDataItem := aData.
	self uninstallFakeNode.
	self installFakeNode 
]

{ #category : #layout }
ToNodeBarContainerElement >> haveInvisibleNodes: invisibleNodes [
]

{ #category : #initialization }
ToNodeBarContainerElement >> initialize [

	super initialize.
	nodeWrapping := true.
	nodeScrolling := false.

	innerNodeContainer := ToPane new.
	scrollable := innerNodeContainer asScrollableElement.
	self addChild: scrollable



]

{ #category : #initialization }
ToNodeBarContainerElement >> installFakeNode [
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
	self isHorizontal
		ifTrue: [
			fakeNode width: 0.
			fakeNode constraintsDo: [ :c |
				c vertical matchParent.
				c flow vertical alignCenter.
				c linear vertical alignCenter ] ]
		ifFalse: [
			fakeNode height: 0.
			fakeNode constraintsDo: [ :c |
				c horizontal matchParent.
				c flow horizontal alignCenter.
				c linear horizontal alignCenter ] ].

	fakeNode margin: BlInsets empty.

	" add the fake node (to keep a constant minimum height )"
	self addFakeNode
]

{ #category : #'t - orientable - accessing' }
ToNodeBarContainerElement >> layoutStrategy [

	^ self layout

	
]

{ #category : #initialization }
ToNodeBarContainerElement >> newNode [

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
ToNodeBarContainerElement >> newNodeHolder [

	^ self nodeHolderClass new elementBar: elementBar; yourself
]

{ #category : #accessing }
ToNodeBarContainerElement >> nodeAutoDistribution [

	^ nodeAutoDistribution
]

{ #category : #accessing }
ToNodeBarContainerElement >> nodeAutoDistribution: aBoolean [

	nodeAutoDistribution := aBoolean
]

{ #category : #accessing }
ToNodeBarContainerElement >> nodeBuilder [
	
	" return a valuable that is used to build a bar node element from a data. 
	aValuable take the bar node element to build as first argument 
	and its holder as second argument"

	^ [ :aBarNode :aNodeHolder |
	  aBarNode middleContainer addChild:
		  (ToLabel text: aNodeHolder dataItem asString) ]
]

{ #category : #accessing }
ToNodeBarContainerElement >> nodeClass [ 

	^ self defaultNodeClass
]

{ #category : #initialization }
ToNodeBarContainerElement >> nodeHolderClass [ 

	^ ToElementBarNodeHolder
]

{ #category : #accessing }
ToNodeBarContainerElement >> nodeHolders [

	^ nodeHolders ifNil: [
		  nodeHolders := OrderedCollection new ]
]

{ #category : #accessing }
ToNodeBarContainerElement >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean
]

{ #category : #accessing }
ToNodeBarContainerElement >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean
]

{ #category : #accessing }
ToNodeBarContainerElement >> nodes [

	^ self nodeHolders collect: [ :h | h node ]

]

{ #category : #accessing }
ToNodeBarContainerElement >> nodesCount [

	| count |
	count := 0.
	self nodeHolders do: [ :nodeHolder |
		count := count + nodeHolder nodesCount ].
	^ count
]

{ #category : #enumerating }
ToNodeBarContainerElement >> nodesDo: aBlock [

	self nodeHolders do: [ :nodeHolder |	aBlock value: nodeHolder node ].
]

{ #category : #enumerating }
ToNodeBarContainerElement >> nodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodeHolders do: [ :nodeHolder |
			  (aBlock value: nodeHolder node) ifTrue: [
				  stream nextPut: nodeHolder node ] ] ]
]

{ #category : #'api - hooks' }
ToNodeBarContainerElement >> onInstalledIn: anElementBar [

	elementBar := anElementBar.
	nodeScrolling := anElementBar nodeScrolling.
	nodeWrapping := anElementBar nodeWrapping.
	nodeAutoDistribution := anElementBar nodeAutoDistribution.

	self isHorizontal
		ifTrue: [
			self
				vFitContent;
				hMatchParent;
				constraintsDo: [ :c | c linear vertical alignCenter ] ]
		ifFalse: [
			self
				hFitContent;
				vMatchParent;
				constraintsDo: [ :c | c linear horizontal alignCenter ] ].

	self isHorizontal
		ifTrue: [
			innerNodeContainer layout: (nodeWrapping
					 ifTrue: [ BlFlowLayout horizontal ]
					 ifFalse: [ BlLinearLayout horizontal ]).
			innerNodeContainer constraintsDo: [ :c |
				c linear vertical alignCenter.
				c flow vertical alignCenter.
				c vertical fitContent.
				nodeScrolling
					ifTrue: [ c horizontal fitContent ]
					ifFalse: [ c horizontal matchParent ] ] ]
		ifFalse: [
			innerNodeContainer layout: (nodeWrapping
					 ifTrue: [ BlFlowLayout vertical ]
					 ifFalse: [ BlLinearLayout vertical ]).
			innerNodeContainer constraintsDo: [ :c |
				c linear horizontal alignCenter.
				c flow horizontal alignCenter.
				c horizontal fitContent.
				nodeScrolling
					ifTrue: [ c vertical fitContent ]
					ifFalse: [ c vertical matchParent ] ] ].
			
	self isHorizontal
		ifTrue: [
			scrollable constraintsDo: [ :c |
				c linear vertical alignCenter.
				c flow vertical alignCenter.
				c vertical fitContent.
				c horizontal matchParent ] ]
		ifFalse: [
			scrollable constraintsDo: [ :c |
				c linear horizontal alignCenter.
				c flow horizontal alignCenter.
				c horizontal fitContent.
				c vertical matchParent ] ].
		
	nodeScrolling ifFalse: [
		nodeAutoDistribution ifTrue: [
			self nodesDo: [ :n | n autoDistribute ] ] ].

	" The textField is added whatever the mode to draw the placeholder text if any.
	In case of read-only mode, the textfield is set as read-only by the mode "
	self installFakeNode
]

{ #category : #layout }
ToNodeBarContainerElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	nodeWrapping ifTrue: [ ^ self ].
	nodeScrolling ifTrue: [ ^ self ].
	self checkVisibleNodes
]

{ #category : #'api - hooks' }
ToNodeBarContainerElement >> onUninstalledIn: anElementBar [

	self nodesDo: [ :node |
		node onUninstalledIn: anElementBar.
		node removeFromParent ].
	self nodeHolders reset.
	self uninstallFakeNode.
	elementBar := nil
]

{ #category : #accessing }
ToNodeBarContainerElement >> refresh [

	self subclassResponsibility 
]

{ #category : #initialization }
ToNodeBarContainerElement >> uninstallFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].
	fakeNode := nil
]
