Class {
	#name : #ToMultipleSelectionElementBarContainerElement,
	#superclass : #ToElementBarNodeContainerElement,
	#instVars : [
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
ToMultipleSelectionElementBarContainerElement >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #adding }
ToMultipleSelectionElementBarContainerElement >> addDataNode: aNode [

	elementBar nodeAutoDistribution ifTrue: [ aNode autoDistribute ].
	innerNodeContainer addChild: aNode before: fakeNode
]

{ #category : #adding }
ToMultipleSelectionElementBarContainerElement >> addFakeNode [

	innerNodeContainer addChild: fakeNode
]

{ #category : #layout }
ToMultipleSelectionElementBarContainerElement >> checkVisibleNodes [

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

{ #category : #layout }
ToMultipleSelectionElementBarContainerElement >> ensurePreviousMeasuredBarWidth [

	previousMeasuredBarWidth ifNil: [
		previousMeasuredBarWidth := self measuredWidth  ]
]

{ #category : #layout }
ToMultipleSelectionElementBarContainerElement >> haveInvisibleNodes: invisibleNodes [
]

{ #category : #initialization }
ToMultipleSelectionElementBarContainerElement >> initialize [

	super initialize.
	nodeWrapping := true.
	nodeScrolling := false

]

{ #category : #testing }
ToMultipleSelectionElementBarContainerElement >> isMultipleSelection [ 

	^ true
]

{ #category : #accessing }
ToMultipleSelectionElementBarContainerElement >> nodeAutoDistribution [

	^ nodeAutoDistribution
]

{ #category : #accessing }
ToMultipleSelectionElementBarContainerElement >> nodeAutoDistribution: aBoolean [

	nodeAutoDistribution := aBoolean.
	self onNodeDistributionChange
]

{ #category : #enumerating }
ToMultipleSelectionElementBarContainerElement >> nodeHolders [

	^ nodeHolders ifNil: [
		  nodeHolders := OrderedCollection new ]
]

{ #category : #accessing }
ToMultipleSelectionElementBarContainerElement >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean.
	self onNodeScrollingChange  
]

{ #category : #accessing }
ToMultipleSelectionElementBarContainerElement >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean.
	self onNodeWrappingChange  
]

{ #category : #accessing }
ToMultipleSelectionElementBarContainerElement >> nodesCount [

	| count |
	count := 0.
	self nodeHolders do: [ :nodeHolder |
		count := count + nodeHolder nodesCount ].
	^ count
]

{ #category : #enumerating }
ToMultipleSelectionElementBarContainerElement >> nodesDo: aBlock [

	self nodeHolders do: [ :nodeHolder |	aBlock value: nodeHolder node ].
]

{ #category : #enumerating }
ToMultipleSelectionElementBarContainerElement >> nodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodeHolders do: [ :nodeHolder |
			  (aBlock value: nodeHolder node) ifTrue: [
				  stream nextPut: nodeHolder node ] ] ]
]

{ #category : #'api - hooks' }
ToMultipleSelectionElementBarContainerElement >> onInstalledIn: anElementBar [

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
ToMultipleSelectionElementBarContainerElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	nodeWrapping ifTrue: [ ^ self ].
	nodeScrolling ifTrue: [ ^ self ].
	self checkVisibleNodes
]

{ #category : #accessing }
ToMultipleSelectionElementBarContainerElement >> onNodeDistributionChange [

	nodeScrolling ifTrue: [ ^ self ].
	nodeAutoDistribution ifTrue: [
		self nodesDo: [ :n | n autoDistribute ] ]
]

{ #category : #accessing }
ToMultipleSelectionElementBarContainerElement >> onNodeScrollingChange [

	innerNodeContainer ifNil: [ ^ self ].
	nodeScrolling
		ifTrue: [
		innerNodeContainer constraintsDo: [ :c | c horizontal fitContent ] ]
		ifFalse: [
		innerNodeContainer constraintsDo: [ :c | c horizontal matchParent ] ]
]

{ #category : #accessing }
ToMultipleSelectionElementBarContainerElement >> onNodeWrappingChange [

	innerNodeContainer ifNil: [ ^ self ].
	innerNodeContainer layout: (nodeWrapping
			 ifTrue: [ BlFlowLayout horizontal ]
			 ifFalse: [ BlLinearLayout horizontal ])
]

{ #category : #'api - hooks' }
ToMultipleSelectionElementBarContainerElement >> onUninstalledIn: anElementBar [

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
