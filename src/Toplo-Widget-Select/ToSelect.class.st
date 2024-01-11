Class {
	#name : #ToSelect,
	#superclass : #ToElement,
	#instVars : [
		'windowManager',
		'icon',
		'contentElement',
		'nodeClass',
		'nodeBuilder',
		'nodeHolders',
		'iconContainer',
		'selectTextField',
		'fakeData',
		'fakeNode',
		'data',
		'selection',
		'dataIndex',
		'removedData',
		'nodeContainer',
		'nodeWrapping'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'accessing nodes' }
ToSelect >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #'accessing list' }
ToSelect >> addData: aData [

	self data add: aData.
	self listElement selection selectIndex: data size
]

{ #category : #'accessing nodes' }
ToSelect >> addDataNode: aNode [

	nodeContainer addChild: aNode before: selectTextField
]

{ #category : #accessing }
ToSelect >> data [

	^ data
]

{ #category : #'accessing nodes' }
ToSelect >> dataNodesDo: aBlock [

	nodeContainer childrenDo: [ :child |
		child ~= selectTextField ifTrue: [ aBlock value: child ] ].
]

{ #category : #initialization }
ToSelect >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder data asString) ]
]

{ #category : #initialization }
ToSelect >> defaultNodeClass [ 

	^ ToSelectNode
]

{ #category : #initialization }
ToSelect >> defaultNodeWrapping [

	^ true
]

{ #category : #'accessing selection' }
ToSelect >> deselectIndex: anIndex [

	selection deselect: anIndex - 1 to: anIndex
]

{ #category : #private }
ToSelect >> fakeData [

	^ fakeData ifNil: [ fakeData := '' ]
]

{ #category : #private }
ToSelect >> fakeData: aData [

	fakeData := aData.
	self initializeFakeNode
]

{ #category : #'accessing selection' }
ToSelect >> filterResultDo: aBlock [

	windowManager filterResultDo: aBlock
]

{ #category : #accessing }
ToSelect >> icon [

	^ icon
]

{ #category : #accessing }
ToSelect >> icon: anElement [

	anElement = self icon ifTrue: [ ^ self ].
	self icon ifNotNil: [ :s | self icon removeFromParent ].
	icon := anElement.
	anElement ifNil: [ ^ self ].
	self iconContainer addChild: anElement
]

{ #category : #accessing }
ToSelect >> iconContainer [

	^ iconContainer
]

{ #category : #initialization }
ToSelect >> initialize [

	| sharedEventsDistributor |
	super initialize.
	nodeWrapping := self defaultNodeWrapping.
	selection := BlCompositeSelection new.
	removedData := IdentitySet new.
	self fitContent.
	self layout: BlLinearLayout horizontal.
	nodeClass := self defaultNodeClass.
	nodeHolders := OrderedCollection new.
	nodeBuilder := self defaultNodeBuilder.

	" the element that holds the flow"
	contentElement := self newContentElement.
	" the flow element taht contains nodes + the text field "
	nodeContainer := self newNodeContainer.

	" the text field for the select input "
	selectTextField := self newSelectTextField.
	selectTextField requestFocus.
	sharedEventsDistributor := BlSharedEventDistributor new.
	sharedEventsDistributor
		adjustMousePosition: false;
		shareEvents: {
				ToCollectionAfterChangeEvent.
				ToListUniqueIndexEvent.
				ToAlbumClientEvent.
				ToListSelectionChangedEvent.
				ToInfiniteSelectionDirtyEvent }.
	selectTextField addEventHandler: sharedEventsDistributor.
	self addEventHandler: sharedEventsDistributor.

	data := ToObservableCollection new.
	windowManager := ToSelectWindowManager new element: self.
	self listElement addEventHandler: sharedEventsDistributor.
	self listElement infinite addEventHandler: sharedEventsDistributor.
	self data addEventHandler: sharedEventsDistributor.
	nodeContainer addChild: selectTextField.
	contentElement addChild: nodeContainer.

	iconContainer := self newIconContainer.
	self addChildren: {
			contentElement.
			iconContainer }.
	self initializeFakeNode 
]

{ #category : #initialization }
ToSelect >> initializeFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeHolder |
	fakeNode := self newNode.
	fakeNode id: #'fakeNode'.
	fakeHolder := self newNodeHolder.
	fakeNode selectHolder: fakeHolder.
	fakeHolder
		node: fakeNode;
		data: self fakeData.
	self nodeBuilder value: fakeNode value: fakeHolder.
	fakeNode width: 0.
	fakeNode constraintsDo: [ :c |
			  c flow vertical alignCenter.
			  c linear vertical alignCenter ].
	self refreshNodes
]

{ #category : #accessing }
ToSelect >> listElement [

	^ self windowManager listElement
]

{ #category : #initialization }
ToSelect >> newContentElement [

	^ ToElement new
		  vFitContent;
		  hMatchParent;
		  id: #contentElement;
		  layout: BlLinearLayout horizontal;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : #initialization }
ToSelect >> newIconContainer [

	^ ToElement new
		  fitContent;
		  id: #iconContainer;
		  layout: BlFrameLayout new;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : #'accessing nodes' }
ToSelect >> newNode [

	^ self nodeClass new
]

{ #category : #initialization }
ToSelect >> newNodeContainer [

	^ ToElement new
		  vFitContent;
		  hMatchParent;
		  id: #'nodeContainer';
		  layout: self newNodeContainerLayout;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : #private }
ToSelect >> newNodeContainerLayout [

	^ nodeWrapping
		ifTrue: [ BlFlowLayout horizontal ]
		ifFalse: [ BlLinearLayout horizontal ]
]

{ #category : #'accessing nodes' }
ToSelect >> newNodeHolder [

	^ self nodeHolderClass new
]

{ #category : #skin }
ToSelect >> newRawSkin [ 

	^ ToSelectSkin new
]

{ #category : #initialization }
ToSelect >> newSelectTextField [

	^ ToSelectTextField new
		  select: self;
		  id: #textField;
		  yourself
]

{ #category : #accessing }
ToSelect >> nodeBuilder [

	" see the mutator method  "
	
	^ nodeBuilder
]

{ #category : #accessing }
ToSelect >> nodeBuilder: aValuable [

	" builds a select node element from list data. 
	aValuable take the select node element to build as first argument 
	and the select node holder as second argument"
	
	nodeBuilder := aValuable.
	self initializeFakeNode
]

{ #category : #accessing }
ToSelect >> nodeClass [ 

	^ nodeClass 
]

{ #category : #accessing }
ToSelect >> nodeClass: aNodeClass [

	nodeClass := aNodeClass.
	self initializeFakeNode
]

{ #category : #accessing }
ToSelect >> nodeContainer [

	^ nodeContainer
]

{ #category : #'accessing nodes' }
ToSelect >> nodeHolderClass [ 

	^ ToSelectNodeHolder
]

{ #category : #'accessing nodes' }
ToSelect >> nodeHolders [

	^ nodeHolders
]

{ #category : #accessing }
ToSelect >> nodeWrapping [

	^ nodeWrapping 
]

{ #category : #accessing }
ToSelect >> nodeWrapping: aBoolean [

	nodeWrapping = aBoolean ifTrue: [ ^ self ].
	nodeWrapping := aBoolean.
	self onNodeWrappingChange.
]

{ #category : #'accessing list' }
ToSelect >> onListCloseRequest [

	self textField requestFocus
]

{ #category : #private }
ToSelect >> onNodeWrappingChange [

	nodeContainer layout: self newNodeContainerLayout
]

{ #category : #'accessing nodes' }
ToSelect >> refreshNodes [

	| nodes |
	" first remove all data nodes "
	self dataNodesDo: [ :node | node removeFromParent ].
	self nodeHolders reset.
	" then rebuild current nodes according to current selection "
	nodes := selection indices collect: [ :idx |
		         | node holder selectedData |
		         node := self newNode.
		         holder := self newNodeHolder.
		         node selectHolder: holder.
		         self nodeHolders add: holder.
		         selectedData := self listElement data at: idx.
		         holder
			         node: node;
			         position: idx;
			         select: self;
			         data: selectedData.
		         self nodeBuilder value: node value: holder.
		         node ].
	self addAllDataNodes: nodes.
	
	" add the fake node if the selection is empty (to keep a constant minimum height )"
	nodes ifEmpty: [ nodeContainer addChild: fakeNode ]
]

{ #category : #'accessing selection' }
ToSelect >> selectIndex: anIndex [

	selection select: anIndex - 1 to: anIndex
]

{ #category : #'accessing selection' }
ToSelect >> selectIndexes: aCollection [

	selection := BlCompositeSelection new.
	aCollection do: [ :idx | selection select: idx - 1 to: idx ]
]

{ #category : #'accessing selection' }
ToSelect >> selectedIndexes [

	^ selection indices
]

{ #category : #accessing }
ToSelect >> selection [

	^ selection
]

{ #category : #accessing }
ToSelect >> textField [

	^ selectTextField 
]

{ #category : #private }
ToSelect >> updateDataIndex [

	dataIndex := IdentityDictionary new.
	self data withIndexDo: [ :d :i | dataIndex at: d put: i ]
]

{ #category : #accessing }
ToSelect >> windowManager [

	^ windowManager 
]
