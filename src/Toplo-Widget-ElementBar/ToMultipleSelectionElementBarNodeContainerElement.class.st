Class {
	#name : #ToMultipleSelectionElementBarNodeContainerElement,
	#superclass : #ToElementBarNodeContainerElement,
	#instVars : [
		'nodeWrapping',
		'nodeScrolling',
		'innerNodeContainer',
		'scrollable',
		'nodeHolders',
		'previousMeasuredBarWidth'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #adding }
ToMultipleSelectionElementBarNodeContainerElement >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #adding }
ToMultipleSelectionElementBarNodeContainerElement >> addDataNode: aNode [

	innerNodeContainer addChild: aNode before: fakeNode 
]

{ #category : #adding }
ToMultipleSelectionElementBarNodeContainerElement >> addFakeNode [

	innerNodeContainer addChild: fakeNode
]

{ #category : #layout }
ToMultipleSelectionElementBarNodeContainerElement >> checkVisibleNodes [

	| invisibleNodes visibleNodes showerNode showerHolder currentHeaderWidth |
	self ensurePreviousMeasuredBarWidth.
	currentHeaderWidth := self measuredBounds width.
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
	visibleNodes := self nodesSelect: [ :n | n isFullyVisible ].
	visibleNodes ifNotEmpty: [
		invisibleNodes := invisibleNodes copyWith: visibleNodes last.
		visibleNodes := visibleNodes copyWithout: visibleNodes last ].
	invisibleNodes do: [ :node | node onUninstalledIn: elementBar ].
	showerHolder := ToCompositeElementBarNodeHolder new elementBar: elementBar.
	showerHolder holders:
		(invisibleNodes collect: [ :node | node holder ]).
	showerNode := ToElementBarNode new.
	showerHolder node: showerNode.
	showerNode holder: showerHolder.
	invisibleNodes do: [ :node |
		innerNodeContainer detachChild: node.
		nodeHolders remove: node holder ].
	nodeHolders add: showerHolder.
	showerNode middleContainer addChild: (ToLabel text:
			 '+ ' , (self nodesCount - visibleNodes size) asString , ' ...').
	self addDataNode: showerNode
]

{ #category : #layout }
ToMultipleSelectionElementBarNodeContainerElement >> ensurePreviousMeasuredBarWidth [

	previousMeasuredBarWidth ifNil: [
		previousMeasuredBarWidth := self measuredBounds width  ]
]

{ #category : #initialization }
ToMultipleSelectionElementBarNodeContainerElement >> initialize [

	super initialize.
	nodeWrapping := true.
	nodeScrolling := false

]

{ #category : #enumerating }
ToMultipleSelectionElementBarNodeContainerElement >> nodeHolders [

	^ nodeHolders ifNil: [
		  nodeHolders := OrderedCollection new ]
]

{ #category : #accessing }
ToMultipleSelectionElementBarNodeContainerElement >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean.
	self onNodeScrollingChange  
]

{ #category : #accessing }
ToMultipleSelectionElementBarNodeContainerElement >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	self onNodeWrappingChange  
]

{ #category : #accessing }
ToMultipleSelectionElementBarNodeContainerElement >> nodesCount [

	| count |
	count := 0.
	self nodeHolders do: [ :nodeHolder |
		count := count + nodeHolder nodesCount ].
	^ count
]

{ #category : #enumerating }
ToMultipleSelectionElementBarNodeContainerElement >> nodesDo: aBlock [

	self nodeHolders do: [ :nodeHolder |	aBlock value: nodeHolder node ].
]

{ #category : #enumerating }
ToMultipleSelectionElementBarNodeContainerElement >> nodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodeHolders do: [ :nodeHolder |
			  (aBlock value: nodeHolder node) ifTrue: [
				  stream nextPut: nodeHolder node ] ] ]
]

{ #category : #'api - hooks' }
ToMultipleSelectionElementBarNodeContainerElement >> onInstalledIn: anElementBar [

	super onInstalledIn: anElementBar.
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
		nodeWrapping
			ifTrue: [ c horizontal matchParent ]
			ifFalse: [ c horizontal fitContent ].
		c vertical fitContent ].

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
ToMultipleSelectionElementBarNodeContainerElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	nodeWrapping ifTrue: [ ^ self ].
	nodeScrolling ifTrue: [ ^ self ].
	self checkVisibleNodes
]

{ #category : #accessing }
ToMultipleSelectionElementBarNodeContainerElement >> onNodeScrollingChange [

	nodeScrolling
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].

]

{ #category : #accessing }
ToMultipleSelectionElementBarNodeContainerElement >> onNodeWrappingChange [

	self layout: (nodeWrapping
			 ifTrue: [ BlFlowLayout horizontal ]
			 ifFalse: [ BlLinearLayout horizontal ])
]

{ #category : #'api - hooks' }
ToMultipleSelectionElementBarNodeContainerElement >> onUninstalledIn: anElementBar [

	self nodesDo: [ :node |
		node onUninstalledIn: anElementBar.
		node removeFromParent ].
	self nodeHolders reset.
	fakeNode onUninstalledIn: anElementBar.
	fakeNode removeFromParent.
	fakeNode := nil.
	innerNodeContainer removeFromParent.
	innerNodeContainer := nil.
	super onUninstalledIn: anElementBar.

]

{ #category : #accessing }
ToMultipleSelectionElementBarNodeContainerElement >> refresh [
	" first remove all data nodes "
	
	| detached newNodes |
	detached := OrderedCollection new.
	self nodesDo: [ :node |
		node onUninstalledIn: elementBar.
		detached add: node.
		innerNodeContainer detachChild: node ].
	self nodeHolders reset.
	" then rebuild current nodes according to current selection "
	newNodes := elementBar selectionModel selectedIndexesCollect: [ :idx |
		| node selectedData |
		node := self newNode.
		selectedData := elementBar dataAccessor at: idx.
		node holder
			position: idx;
			dataItem: selectedData.
		self nodeBuilder value: node value: node holder.
		self nodeHolders add: node holder.
		node ].
	self addAllDataNodes: newNodes.
	detached do: [ :node | innerNodeContainer removeDetachedChild: node].
	scrollable requestLayout 
]
