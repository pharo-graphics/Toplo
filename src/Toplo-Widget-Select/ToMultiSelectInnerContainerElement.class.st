Class {
	#name : #ToMultiSelectInnerContainerElement,
	#superclass : #ToSelectInnerContainerElement,
	#instVars : [
		'barElement',
		'selectListElement'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #accessing }
ToMultiSelectInnerContainerElement >> barElement [ 

	^ barElement
]

{ #category : #'accessing - selection' }
ToMultiSelectInnerContainerElement >> checkHideSelectionFromListElement [
]

{ #category : #'accessing - selection' }
ToMultiSelectInnerContainerElement >> checkMaxSelectedCountFromListElement [
]

{ #category : #initialization }
ToMultiSelectInnerContainerElement >> defaultLayout [ 

	^ BlLinearLayout new
]

{ #category : #accessing }
ToMultiSelectInnerContainerElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #layout }
ToMultiSelectInnerContainerElement >> haveFullyInvisibleNodes: aCollectionOfInvisibleNodes [

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
	showerHolder := ToMultiSelectCompositeInnerNodeHolder new.
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
ToMultiSelectInnerContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #accessing }
ToMultiSelectInnerContainerElement >> nodeScrolling: aBoolean [

	barElement nodeScrolling: aBoolean

]

{ #category : #accessing }
ToMultiSelectInnerContainerElement >> nodeWrapping: aBoolean [

	barElement nodeWrapping: aBoolean

]

{ #category : #accessing }
ToMultiSelectInnerContainerElement >> nodesCount [

	| count |
	count := 0.
	self nodeHolders do: [ :nodeHolder |
		count := count + nodeHolder nodesCount ].
	^ count
]

{ #category : #'api - hooks' }
ToMultiSelectInnerContainerElement >> onInstalledIn: aSelectElement [

	super onInstalledIn: aSelectElement.
	selectListElement := aSelectElement listElement.
	textInputElement := self textInputElementClass new.
	textInputElement onInstalledIn: self.
	
	barElement := ToMultiSelectBarElement new.
	self addChild: barElement.

	textInputElement hFitContent.
	textInputElement constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].
	self addChild: textInputElement

]

{ #category : #'accessing - selection' }
ToMultiSelectInnerContainerElement >> onSelectionChangedInSelectElement: aMultiSelectElement [

	aMultiSelectElement showHidePlaceholder.
	self refresh.
	self checkHideSelectionFromListElement.
	self checkMaxSelectedCountFromListElement.

	aMultiSelectElement listElement notifyPrimarySelectionDirty.
	self requestLayout
]

{ #category : #'api - hooks' }
ToMultiSelectInnerContainerElement >> onUninstalledIn: aSelectElement [

	self removeChild: barElement.
	self removeChild: textInputElement.
	barElement := nil.
	textInputElement onInstalledIn: self.
	textInputElement := nil.
	selectListElement := nil.
	super onUninstalledIn: aSelectElement
]

{ #category : #window }
ToMultiSelectInnerContainerElement >> onWindowClosed [

	self textInputElement onWindowClosed
]

{ #category : #window }
ToMultiSelectInnerContainerElement >> onWindowOpened [

	self textInputElement onWindowOpened
]

{ #category : #accessing }
ToMultiSelectInnerContainerElement >> refresh [
	" first remove all data nodes "

	| sieve |
	barElement selecter deselectAll.
	barElement dataAccessor removeAll.
	sieve := windowManager sieve.
	sieve selectionModel selectedIndexesDo: [ :idx |
		barElement dataAccessor add: (sieve originalData at: idx) ]
]

{ #category : #accessing }
ToMultiSelectInnerContainerElement >> refreshOld [
	" first remove all data nodes "
	| detached newNodes |
	true ifTrue: [ ^ self ].
	detached := OrderedCollection new.
	barElement dataAccessor do: [ :node |
		detached add: node.
	].
	" then rebuild current nodes according to current selection "
	newNodes := barElement selectionModel selectedIndexesCollect: [ :idx |
		| node selectedData |
		node := self newNode.
		selectedData := barElement dataAccessor at: idx.
		node holder
			position: idx;
			dataItem: selectedData.
		self nodeBuilder value: node value: node holder.
		self nodeHolders add: node holder.
		node ].
	self addAllDataNodes: newNodes.
	"detached do: [ :node | innerNodeContainer removeDetachedChild: node]."
	barElement requestLayout.
	textInputElement requestLayout
]

{ #category : #accessing }
ToMultiSelectInnerContainerElement >> textInputElement [ 

	^ textInputElement 
]

{ #category : #initialization }
ToMultiSelectInnerContainerElement >> textInputElementClass [

	^ ToMultiSelectTextInputElement
]
