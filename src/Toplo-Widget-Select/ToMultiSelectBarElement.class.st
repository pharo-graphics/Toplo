Class {
	#name : #ToMultiSelectBarElement,
	#superclass : #ToBarElement,
	#traits : 'TToSelectInnerContainerElement',
	#classTraits : 'TToSelectInnerContainerElement classTrait',
	#instVars : [
		'selectElement',
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> checkHideSelectionFromListElement [
]

{ #category : #'accessing - selection' }
ToMultiSelectBarElement >> checkMaxSelectedCountFromListElement [
]

{ #category : #initialization }
ToMultiSelectBarElement >> defaultEventHandler [ 

	^ ToMultiSelectBarEventHandler new
]

{ #category : #initialization }
ToMultiSelectBarElement >> defaultNodeManager [

	^ ToMultiSelectBarNodeManager new
]

{ #category : #layout }
ToMultiSelectBarElement >> haveFullyInvisibleNodes: aCollectionOfInvisibleNodes [

	| visibleNodes invisibleNodes showerHolder showerNode lab nodeHolders |
	self flag: 'ToDo or Remove'.
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
	invisibleNodes do: [ :node | node onUninstalledIn: self ].
	" now cumulate invisible nodes in a composite holder "
	showerHolder := ToMultiSelectCompositeInnerNodeHolder new.
	showerHolder elementBar: self.
	showerHolder holders:
		(invisibleNodes collect: [ :node | node holder ]).
	showerNode := self defaultNodeClass new.
	showerHolder node: showerNode.
	showerNode holder: showerHolder.
	invisibleNodes do: [ :node |
		self innerContainer detachChild: node.
		nodeHolders remove: node holder ].
	nodeHolders add: showerHolder.
	lab := ToLabel text:
		       '+ ' , (self nodesCount - visibleNodes size) asString
		       , ' ...'.
	showerNode middleContainer addChild: lab.
	self addDataNode: showerNode
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> isMultipleSelection [ 

	^ true
]

{ #category : #skin }
ToMultiSelectBarElement >> newRawSkin [ 

	^ ToMultiSelectBarElementSkin new
]

{ #category : #accessing }
ToMultiSelectBarElement >> nodesCount [

	| count |
	count := 0.
	self nodeHolders do: [ :nodeHolder |
		count := count + nodeHolder nodesCount ].
	^ count
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> refresh [
	" first remove all data nodes "

	| sieve |
	self selecter deselectAll.
	self dataAccessor removeAll.
	sieve := self windowManager sieve.
	sieve selectionModel selectedIndexesDo: [ :idx |
		self dataAccessor add: (sieve originalData at: idx) ].
	self checkHideSelectionFromListElement.
	self checkMaxSelectedCountFromListElement.

]

{ #category : #accessing }
ToMultiSelectBarElement >> refreshOld [
	" first remove all data nodes "
	| detached newNodes |
	true ifTrue: [ ^ self ].
	detached := OrderedCollection new.
	self dataAccessor do: [ :node |
		detached add: node.
	].
	" then rebuild current nodes according to current selection "
	newNodes := self selectionModel selectedIndexesCollect: [ :idx |
		| node selectedData |
		node := self newNode.
		selectedData := self dataAccessor at: idx.
		node holder
			position: idx;
			dataItem: selectedData.
		self nodeBuilder value: node value: node holder.
		self nodeHolders add: node holder.
		node ].
	self addAllDataNodes: newNodes.
	"detached do: [ :node | innerNodeContainer removeDetachedChild: node]."
	self requestLayout.
	textInputElement requestLayout
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> selectElement [

	^ selectElement
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> selectElement: aSelectElement [

	selectElement := aSelectElement.
	textInputElement := self textInputElementClass new.
	textInputElement onInstalledIn: self.
	
	textInputElement hFitContent.
	textInputElement constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].
	self addChild: textInputElement

]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> textInputElement [ 

	^ textInputElement 
]

{ #category : #'t - select inner container' }
ToMultiSelectBarElement >> textInputElementClass [

	^ ToMultiSelectTextInputElement
]
