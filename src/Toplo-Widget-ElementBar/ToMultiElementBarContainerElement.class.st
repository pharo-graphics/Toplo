Class {
	#name : #ToMultiElementBarContainerElement,
	#superclass : #ToElementBarContainerElement,
	#instVars : [
		'nodeWrapping',
		'nodeScrolling',
		'nodeAutoDistribution',
		'scrollable',
		'nodeHolders',
		'previousMeasuredBarWidth'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #adding }
ToMultiElementBarContainerElement >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #adding }
ToMultiElementBarContainerElement >> addDataNode: aNode [

	elementBar nodeAutoDistribution ifTrue: [ aNode autoDistribute ].
	innerNodeContainer addChild: aNode before: fakeNode
]

{ #category : #layout }
ToMultiElementBarContainerElement >> checkVisibleNodes [

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
ToMultiElementBarContainerElement >> ensurePreviousMeasuredBarWidth [

	previousMeasuredBarWidth ifNil: [
		previousMeasuredBarWidth := self measuredWidth  ]
]

{ #category : #layout }
ToMultiElementBarContainerElement >> haveInvisibleNodes: invisibleNodes [
]

{ #category : #initialization }
ToMultiElementBarContainerElement >> initialize [

	super initialize.
	nodeWrapping := true.
	nodeScrolling := false

]

{ #category : #accessing }
ToMultiElementBarContainerElement >> nodeAutoDistribution [

	^ nodeAutoDistribution
]

{ #category : #accessing }
ToMultiElementBarContainerElement >> nodeAutoDistribution: aBoolean [

	nodeAutoDistribution := aBoolean
]

{ #category : #accessing }
ToMultiElementBarContainerElement >> nodeHolders [

	^ nodeHolders ifNil: [
		  nodeHolders := OrderedCollection new ]
]

{ #category : #accessing }
ToMultiElementBarContainerElement >> nodeScrolling: aBoolean [

	nodeScrolling := aBoolean
]

{ #category : #accessing }
ToMultiElementBarContainerElement >> nodeWrapping: aBoolean [

	nodeWrapping := aBoolean
]

{ #category : #accessing }
ToMultiElementBarContainerElement >> nodes [

	^ self nodeHolders collect: [ :h | h node ]

]

{ #category : #accessing }
ToMultiElementBarContainerElement >> nodesCount [

	| count |
	count := 0.
	self nodeHolders do: [ :nodeHolder |
		count := count + nodeHolder nodesCount ].
	^ count
]

{ #category : #enumerating }
ToMultiElementBarContainerElement >> nodesDo: aBlock [

	self nodeHolders do: [ :nodeHolder |	aBlock value: nodeHolder node ].
]

{ #category : #enumerating }
ToMultiElementBarContainerElement >> nodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodeHolders do: [ :nodeHolder |
			  (aBlock value: nodeHolder node) ifTrue: [
				  stream nextPut: nodeHolder node ] ] ]
]

{ #category : #'api - hooks' }
ToMultiElementBarContainerElement >> onInstalledIn: anElementBar [

	super onInstalledIn: anElementBar.

	nodeScrolling := anElementBar nodeScrolling.
	nodeWrapping := anElementBar nodeWrapping.
	nodeAutoDistribution := anElementBar nodeAutoDistribution.

	innerNodeContainer := ToElement new.

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

	scrollable := innerNodeContainer asScrollableElement.

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
	self addChild: scrollable.
	self installFakeNode
]

{ #category : #layout }
ToMultiElementBarContainerElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	nodeWrapping ifTrue: [ ^ self ].
	nodeScrolling ifTrue: [ ^ self ].
	self checkVisibleNodes
]

{ #category : #'api - hooks' }
ToMultiElementBarContainerElement >> onUninstalledIn: anElementBar [

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
	super onUninstalledIn: anElementBar
]
