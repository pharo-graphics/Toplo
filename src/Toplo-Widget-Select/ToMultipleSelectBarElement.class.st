Class {
	#name : #ToMultipleSelectBarElement,
	#superclass : #ToBarElement,
	#instVars : [
		'fakeNode',
		'nodeBar',
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #adding }
ToMultipleSelectBarElement >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #adding }
ToMultipleSelectBarElement >> addDataNode: aNode [

	self listElement nodeAutoDistribution ifTrue: [ aNode autoDistribute ].
	self dataAccessor add: aNode
]

{ #category : #adding }
ToMultipleSelectBarElement >> addFakeNode [

	self addChild: fakeNode
]

{ #category : #initialization }
ToMultipleSelectBarElement >> defaultNodeClass [ 

	^ ToMultipleSelectNode
]

{ #category : #accessing }
ToMultipleSelectBarElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #layout }
ToMultipleSelectBarElement >> haveFullyInvisibleNodes: aCollectionOfInvisibleNodes [

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
ToMultipleSelectBarElement >> initialize [ 

	super initialize.
	nodeBar := ToBarElement new.
	textInputElement := ToMultiSelectTextInputElement new.

]

{ #category : #accessing }
ToMultipleSelectBarElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #testing }
ToMultipleSelectBarElement >> isSingleNode [ 

	^ false
]

{ #category : #initialization }
ToMultipleSelectBarElement >> nodeBuilder [
	" return a valuable that is used to build a bar node element from a data. 
	aValuable take the bar node element to build as first argument 
	and its holder as second argument"

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder dataItem asString) ]
]

{ #category : #accessing }
ToMultipleSelectBarElement >> nodesCount [

	| count |
	count := 0.
	self nodeHolders do: [ :nodeHolder |
		count := count + nodeHolder nodesCount ].
	^ count
]

{ #category : #'api - hooks' }
ToMultipleSelectBarElement >> onInstalledIn: aSelectElement [

	textInputElement onInstalledIn: aSelectElement.
	textInputElement hFitContent.
	textInputElement constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].
	self addChild: textInputElement
]

{ #category : #'api - hooks' }
ToMultipleSelectBarElement >> onUninstalledIn: aSelectElement [

	textInputElement onUninstalledIn: aSelectElement
]

{ #category : #window }
ToMultipleSelectBarElement >> onWindowClosed [

	self textInputElement onWindowClosed
]

{ #category : #window }
ToMultipleSelectBarElement >> onWindowOpened [

	self textInputElement onWindowOpened
]

{ #category : #accessing }
ToMultipleSelectBarElement >> refresh [
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
ToMultipleSelectBarElement >> textInputElement [ 

	^ textInputElement 
]

{ #category : #initialization }
ToMultipleSelectBarElement >> uninstallFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	fakeNode ifNotNil: [ :fn |
		fn onUninstalledIn: self.
		fn removeFromParent ].
	fakeNode := nil
]
