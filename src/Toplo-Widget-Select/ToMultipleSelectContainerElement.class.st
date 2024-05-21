Class {
	#name : #ToMultipleSelectContainerElement,
	#superclass : #ToMultiElementBarContainerElement,
	#instVars : [
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultipleSelectContainerElement >> defaultNodeClass [ 

	^ ToMultipleSelectNode
]

{ #category : #accessing }
ToMultipleSelectContainerElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #layout }
ToMultipleSelectContainerElement >> haveInvisibleNodes: aCollectionOfInvisibleNodes [

	| visibleNodes invisibleNodes showerHolder showerNode lab |
	" in case of composite node at first it means that 
	there is no more visible node to cumulate in a composite node"
	(self nodeHolders size = 1 and: [
		 self nodeHolders first nodesCount > 1 ]) ifTrue: [ ^ self ].
	visibleNodes := self nodesSelect: [ :n | n isFullyVisible ].
	invisibleNodes := aCollectionOfInvisibleNodes.
	visibleNodes ifNotEmpty: [
		invisibleNodes := aCollectionOfInvisibleNodes copyWith:
			                  visibleNodes last.
		visibleNodes := visibleNodes copyWithout: visibleNodes last ].
	invisibleNodes do: [ :node | node onUninstalledIn: elementBar ].
	" now cumulate invisible nodes in a composite holder "
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

{ #category : #initialization }
ToMultipleSelectContainerElement >> initialize [ 

	super initialize.
	textInputElement := ToMultiSelectTextInputElement new.

]

{ #category : #accessing }
ToMultipleSelectContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #testing }
ToMultipleSelectContainerElement >> isSingleNode [ 

	^ false
]

{ #category : #initialization }
ToMultipleSelectContainerElement >> nodeBuilder [
	" return a valuable that is used to build a bar node element from a data. 
	aValuable take the bar node element to build as first argument 
	and its holder as second argument"

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder dataItem asString) ]
]

{ #category : #'api - hooks' }
ToMultipleSelectContainerElement >> onInstalledIn: anElementBar [

	super onInstalledIn: anElementBar.

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
ToMultipleSelectContainerElement >> onUninstalledIn: anElementBar [

	textInputElement onUninstalledIn: anElementBar.
	super onUninstalledIn: anElementBar.

]

{ #category : #window }
ToMultipleSelectContainerElement >> onWindowClosed [

	self textInputElement onWindowClosed
]

{ #category : #window }
ToMultipleSelectContainerElement >> onWindowOpened [

	self textInputElement onWindowOpened
]

{ #category : #accessing }
ToMultipleSelectContainerElement >> refresh [
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
ToMultipleSelectContainerElement >> textInputElement [ 

	^ textInputElement 
]
