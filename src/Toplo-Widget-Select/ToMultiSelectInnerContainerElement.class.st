Class {
	#name : #ToMultiSelectInnerContainerElement,
	#superclass : #ToSelectInnerContainerElement,
	#instVars : [
		'barElement'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #adding }
ToMultiSelectInnerContainerElement >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #adding }
ToMultiSelectInnerContainerElement >> addDataNode: aNode [

	barElement nodeAutoDistribution ifTrue: [ aNode autoDistribute ].
	barElement dataAccessor add: aNode
]

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

{ #category : #initialization }
ToMultiSelectInnerContainerElement >> initialize [

	super initialize.
	barElement := ToBarElement new.
	barElement nodeBuilder: self nodeBuilder
]

{ #category : #accessing }
ToMultiSelectInnerContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #initialization }
ToMultiSelectInnerContainerElement >> nodeBuilder [
	" 
	In a select, a data ietm is a view built 
	return a valuable that is used to build a bar node element from a data. 
	aValuable take the bar node element to build as first argument 
	its holder as second argument and the dataItemView as third argument"

	^ [ :aNode :aNodeHolder :anInnerNode |
	  aNode addChild: anInnerNode ]
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
	textInputElement := self textInputElementClass new.
	textInputElement onInstalledIn: self.

	self addChild: barElement.
	
	" add the fake node (to keep a constant minimum height )"
	fakeView := dataItemViewFactory value.
	fakeView selectElement: aSelectElement.
	fakeView onInstalledIn: self.
	dataItemViewBuilder cull: fakeView cull: nil cull: fakeDataItem.
	fakeView id: #fakeNode.
	fakeView width: 0.
	barElement fakeDataItem: fakeView.
	
	textInputElement hFitContent.
	textInputElement constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].
	self addChild: textInputElement

]

{ #category : #'accessing - selection' }
ToMultiSelectInnerContainerElement >> onSelectionChangedInSelectElement: aMultiSelectElement [

	aMultiSelectElement showHidePlaceholder.
	self refreshBarElement.
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
	fakeView onUninstalledIn: self.
	fakeView := nil.
	textInputElement onInstalledIn: self.
	textInputElement := nil.
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
ToMultiSelectInnerContainerElement >> refreshBarElement [
	" first remove all data nodes "
	| detached newNodes |
	
	detached := OrderedCollection new.
	
	" data items of the node bar are instances of ToMultiSelectNodeContent "
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
