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
	invisibleNodes do: [ :node | node onUninstalledIn: select ].
	showerHolder := ToCompositeHeaderNodeHolder new select: select.
	showerHolder holders:
		(invisibleNodes collect: [ :node | node selectHolder ]).
	showerNode := ToInvisibleSelectHeaderNodesShower new.
	showerHolder node: showerNode.
	showerNode selectHolder: showerHolder.
	invisibleNodes do: [ :node |
		self detachChild: node.
		headerNodeHolders remove: node selectHolder ].
	headerNodeHolders add: showerHolder.
	showerNode middleContainer addChild: (ToLabel text:
			 '+ ' , (self nodesCount - visibleNodes size) asString , ' ...').
	self addDataNode: showerNode
]

{ #category : #layout }
ToMultipleSelectHeaderNodeContainerElement >> computedHeaderWidth [

	^ (select headerElement measuredBounds inParent: select) width
	  - select textInputElement measuredWidth
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> defaultHeaderNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder data asString) ]
]

{ #category : #accessing }
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

	self headerNodeHolders do: [ :holder |	aBlock value: holder node ].
]

{ #category : #enumerating }
ToMultipleSelectHeaderNodeContainerElement >> headerDataNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self headerNodeHolders do: [ :holder |
			  (aBlock value: holder node) ifTrue: [
				  stream nextPut: holder node ] ] ]
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
	self headerNodeHolders do: [ :holder |
		count := count + holder nodesCount ].
	^ count
]

{ #category : #'api - hooks' }
ToMultipleSelectHeaderNodeContainerElement >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	self layout: (aSelect nodeWrapping
			 ifTrue: [ BlFlowLayout horizontal ]
			 ifFalse: [ BlLinearLayout horizontal ]).
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	" The textField is added whatever the mode to draw the placeholder text if any.
	In case of read-only mode, the textfield is set as read-only by the mode "
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: select.
	textInputElement hFitContent.
	self addChild: textInputElement.
	self initializeFakeNode
]

{ #category : #layout }
ToMultipleSelectHeaderNodeContainerElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self checkVisibleNodes 

]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> onNodeWrappingChange [

	self layout: (select nodeWrapping
			 ifTrue: [ BlFlowLayout horizontal ]
			 ifFalse: [ BlLinearLayout horizontal ])
]

{ #category : #'api - hooks' }
ToMultipleSelectHeaderNodeContainerElement >> onUninstalledIn: aSelect [

	self headerDataNodesDo: [ :node |
		node onUninstalledIn: select.
		node removeFromParent ].
	textInputElement onUninstalledIn: select.
	textInputElement removeFromParent.
	textInputElement := nil.
	self headerNodeHolders reset.
	fakeNode onUninstalledIn: select.
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
		node onUninstalledIn: select.
		detached add: node.
		self detachChild: node ].
	self headerNodeHolders reset.
	" then rebuild current nodes according to current selection "
	newNodes := select selectionModel selectedIndexesCollect: [ :idx |
		| node selectedData |
		node := self newHeaderNode.
		selectedData := select dataAccessor at: idx.
		node selectHolder
			position: idx;
			data: selectedData.
		self headerNodeBuilder value: node value: node selectHolder.
		self headerNodeHolders add: node selectHolder.
		node ].
	self addAllDataNodes: newNodes.
	detached do: [ :node | self removeDetachedChild: node]
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> textInputElement [ 

	^ textInputElement 
]
