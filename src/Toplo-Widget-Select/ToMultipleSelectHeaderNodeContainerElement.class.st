Class {
	#name : #ToMultipleSelectHeaderNodeContainerElement,
	#superclass : #ToSelectHeaderNodeContainerElement,
	#instVars : [
		'textInputElement',
		'headerNodeHolders',
		'previousHeaderWidth'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #adding }
ToMultipleSelectHeaderNodeContainerElement >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #adding }
ToMultipleSelectHeaderNodeContainerElement >> addDataNode: aNode [

	self addChild: aNode before: self textInputElement
]

{ #category : #layout }
ToMultipleSelectHeaderNodeContainerElement >> checkVisibleNodes [

	| invisibleNodes visibleNodes showerNode showerHolder currentHeaderWidth |
	self ensurePreviousHeaderWidth.
	currentHeaderWidth := self computedHeaderWidth.
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
	invisibleNodes do: [ :node | node onUninstalledIn: holder ].
	showerHolder := ToCompositeHeaderNodeHolder new headerElement: holder.
	showerHolder holders:
		(invisibleNodes collect: [ :node | node headerNodeHolder ]).
	showerNode := ToInvisibleSelectHeaderNodesShower new.
	showerHolder node: showerNode.
	showerNode headerNodeHolder: showerHolder.
	invisibleNodes do: [ :node |
		self detachChild: node.
		headerNodeHolders remove: node headerNodeHolder ].
	headerNodeHolders add: showerHolder.
	showerNode middleContainer addChild: (ToLabel text:
			 '+ ' , (self nodesCount - visibleNodes size) asString , ' ...').
	self addDataNode: showerNode
]

{ #category : #layout }
ToMultipleSelectHeaderNodeContainerElement >> computedHeaderWidth [

	^ (holder measuredBounds inParent: holder) width
	  - holder textInputElement measuredWidth
]

{ #category : #initialization }
ToMultipleSelectHeaderNodeContainerElement >> defaultHeaderNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder data asString) ]
]

{ #category : #initialization }
ToMultipleSelectHeaderNodeContainerElement >> defaultHeaderNodeClass [ 

	^ ToVisibleSelectHeaderNode
]

{ #category : #layout }
ToMultipleSelectHeaderNodeContainerElement >> ensurePreviousHeaderWidth [

	previousHeaderWidth ifNil: [
		previousHeaderWidth := self computedHeaderWidth  ]
]

{ #category : #enumerating }
ToMultipleSelectHeaderNodeContainerElement >> headerDataNodesDo: aBlock [

	self headerNodeHolders do: [ :nodeHolder |	aBlock value: nodeHolder node ].
]

{ #category : #enumerating }
ToMultipleSelectHeaderNodeContainerElement >> headerDataNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self headerNodeHolders do: [ :nodeHolder |
			  (aBlock value: nodeHolder node) ifTrue: [
				  stream nextPut: nodeHolder node ] ] ]
]

{ #category : #enumerating }
ToMultipleSelectHeaderNodeContainerElement >> headerNodeHolders [

	^ headerNodeHolders ifNil: [
		  headerNodeHolders := OrderedCollection new ]
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> nodesCount [

	| count |
	count := 0.
	self headerNodeHolders do: [ :nodeHolder |
		count := count + nodeHolder nodesCount ].
	^ count
]

{ #category : #'api - hooks' }
ToMultipleSelectHeaderNodeContainerElement >> onInstalledIn: aHolder [

	super onInstalledIn: aHolder.
	self layout: (nodeWrapping
			 ifTrue: [ BlFlowLayout horizontal ]
			 ifFalse: [ BlLinearLayout horizontal ]).
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	" The textField is added whatever the mode to draw the placeholder text if any.
	In case of read-only mode, the textfield is set as read-only by the mode "
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: aHolder.
	textInputElement hFitContent.
	self addChild: textInputElement.
	self initializeFakeNode
]

{ #category : #layout }
ToMultipleSelectHeaderNodeContainerElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	nodeWrapping ifTrue: [ ^ self ].
	self checkVisibleNodes
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> onNodeWrappingChange [

	self layout: (nodeWrapping
			 ifTrue: [ BlFlowLayout horizontal ]
			 ifFalse: [ BlLinearLayout horizontal ])
]

{ #category : #'api - hooks' }
ToMultipleSelectHeaderNodeContainerElement >> onUninstalledIn: aSelect [

	self headerDataNodesDo: [ :node |
		node onUninstalledIn: holder.
		node removeFromParent ].
	textInputElement onUninstalledIn: holder.
	textInputElement removeFromParent.
	textInputElement := nil.
	self headerNodeHolders reset.
	fakeNode onUninstalledIn: holder.
	fakeNode removeFromParent.
	fakeNode := nil.
	super onUninstalledIn: aSelect.

]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> refresh [
	" first remove all data nodes "
	
	| detached newNodes |
	detached := OrderedCollection new.
	self headerDataNodesDo: [ :node |
		node onUninstalledIn: holder.
		detached add: node.
		self detachChild: node ].
	self headerNodeHolders reset.
	" then rebuild current nodes according to current selection "
	newNodes := holder selectionModel selectedIndexesCollect: [ :idx |
		| node selectedData |
		node := self newHeaderNode.
		selectedData := holder dataAccessor at: idx.
		node headerNodeHolder
			position: idx;
			data: selectedData.
		self headerNodeBuilder value: node value: node headerNodeHolder.
		self headerNodeHolders add: node headerNodeHolder.
		node ].
	self addAllDataNodes: newNodes.
	detached do: [ :node | self removeDetachedChild: node]
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> textInputElement [ 

	^ textInputElement 
]
