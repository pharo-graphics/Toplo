Class {
	#name : #ToMultipleSelectionElementBarNodeContainerElement,
	#superclass : #ToElementBarNodeContainerElement,
	#instVars : [
		'nodeWrapping',
		'nodeScrolling',
		'textInputElement',
		'headerNodeHolders',
		'previousHeaderWidth',
		'innerNodeContainer',
		'scrollable'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #adding }
ToMultipleSelectionElementBarNodeContainerElement >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #adding }
ToMultipleSelectionElementBarNodeContainerElement >> addDataNode: aNode [

	nodeWrapping
		ifTrue: [
		innerNodeContainer addChild: aNode before: textInputElement ]
		ifFalse: [ innerNodeContainer addChild: aNode ]
]

{ #category : #layout }
ToMultipleSelectionElementBarNodeContainerElement >> checkVisibleNodes [

	| invisibleNodes visibleNodes showerNode showerHolder currentHeaderWidth |
	self ensurePreviousHeaderWidth.
	currentHeaderWidth := self computedBarWidth.
	currentHeaderWidth > previousHeaderWidth ifTrue: [
		previousHeaderWidth := currentHeaderWidth.
		self enqueueTask: (BlTaskAction new action: [ self refresh ]).
		^ self ].
	(self headerNodeHolders size = 1 and: [
		 self headerNodeHolders first nodesCount > 1 ]) ifTrue: [ ^ self ].

	previousHeaderWidth := currentHeaderWidth.
	invisibleNodes := self headerDataNodesSelect: [ :n |
		                  n isFullyVisible not ].
	invisibleNodes ifEmpty: [ ^ self ].
	visibleNodes := self headerDataNodesSelect: [ :n | n isFullyVisible ].
	visibleNodes ifNotEmpty: [
		invisibleNodes := invisibleNodes copyWith: visibleNodes last.
		visibleNodes := visibleNodes copyWithout: visibleNodes last ].
	invisibleNodes do: [ :node | node onUninstalledIn: elementBar ].
	showerHolder := ToCompositeElementBarNodeHolder new elementBar: elementBar.
	showerHolder holders:
		(invisibleNodes collect: [ :node | node barHolder ]).
	showerNode := ToElementBarNode new.
	showerHolder node: showerNode.
	showerNode barHolder: showerHolder.
	invisibleNodes do: [ :node |
		innerNodeContainer detachChild: node.
		headerNodeHolders remove: node barHolder ].
	headerNodeHolders add: showerHolder.
	showerNode middleContainer addChild: (ToLabel text:
			 '+ ' , (self nodesCount - visibleNodes size) asString , ' ...').
	self addDataNode: showerNode
]

{ #category : #layout }
ToMultipleSelectionElementBarNodeContainerElement >> computedBarWidth [

	^ (elementBar measuredBounds inParent: elementBar) width
	  - textInputElement measuredWidth
]

{ #category : #initialization }
ToMultipleSelectionElementBarNodeContainerElement >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder data asString) ]
]

{ #category : #initialization }
ToMultipleSelectionElementBarNodeContainerElement >> defaultNodeClass [ 

	^ ToMultipleSelectNode
]

{ #category : #layout }
ToMultipleSelectionElementBarNodeContainerElement >> ensurePreviousHeaderWidth [

	previousHeaderWidth ifNil: [
		previousHeaderWidth := self computedBarWidth  ]
]

{ #category : #enumerating }
ToMultipleSelectionElementBarNodeContainerElement >> headerDataNodesDo: aBlock [

	self headerNodeHolders do: [ :nodeHolder |	aBlock value: nodeHolder node ].
]

{ #category : #enumerating }
ToMultipleSelectionElementBarNodeContainerElement >> headerDataNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self headerNodeHolders do: [ :nodeHolder |
			  (aBlock value: nodeHolder node) ifTrue: [
				  stream nextPut: nodeHolder node ] ] ]
]

{ #category : #enumerating }
ToMultipleSelectionElementBarNodeContainerElement >> headerNodeHolders [

	^ headerNodeHolders ifNil: [
		  headerNodeHolders := OrderedCollection new ]
]

{ #category : #initialization }
ToMultipleSelectionElementBarNodeContainerElement >> initialize [

	super initialize.
	nodeWrapping := true.
	nodeScrolling := false

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
	self headerNodeHolders do: [ :nodeHolder |
		count := count + nodeHolder nodesCount ].
	^ count
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

	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: anElementBar.
	textInputElement hFitContent.
	textInputElement constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].
	nodeWrapping
		ifTrue: [ innerNodeContainer addChild: textInputElement ]
		ifFalse: [ self addChild: textInputElement ].
	self initializeFakeNode
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

	self headerDataNodesDo: [ :node |
		node onUninstalledIn: anElementBar.
		node removeFromParent ].
	textInputElement onUninstalledIn: anElementBar.
	textInputElement removeFromParent.
	textInputElement := nil.
	self headerNodeHolders reset.
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
	self headerDataNodesDo: [ :node |
		node onUninstalledIn: elementBar.
		detached add: node.
		innerNodeContainer detachChild: node ].
	self headerNodeHolders reset.
	" then rebuild current nodes according to current selection "
	newNodes := elementBar selectionModel selectedIndexesCollect: [ :idx |
		| node selectedData |
		node := self newNode.
		selectedData := elementBar dataAccessor at: idx.
		node barHolder
			position: idx;
			data: selectedData.
		self nodeBuilder value: node value: node barHolder.
		self headerNodeHolders add: node barHolder.
		node ].
	self addAllDataNodes: newNodes.
	detached do: [ :node | innerNodeContainer removeDetachedChild: node].
	textInputElement requestLayout.
	scrollable requestLayout 
]

{ #category : #accessing }
ToMultipleSelectionElementBarNodeContainerElement >> textInputElement [ 

	^ textInputElement 
]
