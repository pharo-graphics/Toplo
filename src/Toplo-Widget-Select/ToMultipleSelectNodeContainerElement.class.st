Class {
	#name : #ToMultipleSelectNodeContainerElement,
	#superclass : #ToMultipleSelectionElementBarContainerElement,
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToMultipleSelectNodeContainerElement >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder dataItem asString) ]
]

{ #category : #initialization }
ToMultipleSelectNodeContainerElement >> defaultNodeClass [ 

	^ ToMultipleSelectNode
]

{ #category : #accessing }
ToMultipleSelectNodeContainerElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #layout }
ToMultipleSelectNodeContainerElement >> haveInvisibleNodes: aCollectionOfInvisibleNodes [

	| visibleNodes invisibleNodes showerHolder showerNode lab |
	visibleNodes := self nodesSelect: [ :n | n isFullyVisible ].
	invisibleNodes := aCollectionOfInvisibleNodes.
	visibleNodes ifNotEmpty: [
		invisibleNodes := aCollectionOfInvisibleNodes copyWith:
			                  visibleNodes last.
		visibleNodes := visibleNodes copyWithout: visibleNodes last ].
	invisibleNodes do: [ :node | node onUninstalledIn: elementBar ].
	showerHolder := ToCompositeElementBarNodeHolder new.
	showerHolder elementBar: elementBar.
	showerHolder holders:
		(invisibleNodes collect: [ :node | node holder ]).
	showerNode := self defaultNodeClass new.
	showerHolder node: showerNode.
	showerNode holder: showerHolder.
	invisibleNodes do: [ :node |
		innerNodeContainer detachChild: node.
		nodeHolders remove: node holder ].
	nodeHolders add: showerHolder.
	lab := ToLabel text:
		       '+ ' , (self nodesCount - visibleNodes size) asString
		       , ' ...'.
	showerNode middleContainer addChild: lab.
	self addDataNode: showerNode
]

{ #category : #accessing }
ToMultipleSelectNodeContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #'api - hooks' }
ToMultipleSelectNodeContainerElement >> onInstalledIn: anElementBar [

	super onInstalledIn: anElementBar.
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: self.
	textInputElement hFitContent.
	textInputElement constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].
	nodeWrapping
		ifTrue: [ innerNodeContainer addChild: textInputElement after: fakeNode ]
		ifFalse: [ self addChild: textInputElement ]
]

{ #category : #'api - hooks' }
ToMultipleSelectNodeContainerElement >> onUninstalledIn: anElementBar [

	textInputElement onUninstalledIn: anElementBar.
	textInputElement removeFromParent.
	textInputElement := nil.
	super onUninstalledIn: anElementBar.

]

{ #category : #accessing }
ToMultipleSelectNodeContainerElement >> refresh [
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
	scrollable requestLayout.
	textInputElement requestLayout
]

{ #category : #accessing }
ToMultipleSelectNodeContainerElement >> textInputElement [ 

	^ textInputElement 
]
