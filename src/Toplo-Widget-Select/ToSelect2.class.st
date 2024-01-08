Class {
	#name : #ToSelect2,
	#superclass : #ToPane,
	#instVars : [
		'windowManager',
		'icon',
		'contentElement',
		'nodeClass',
		'nodeBuilder',
		'nodeHolders',
		'iconContainer',
		'selectTextField',
		'selectFlow',
		'fakeData',
		'fakeNode',
		'data'
	],
	#category : #'Toplo-Widget-Select'
}

{ #category : #accessing }
ToSelect2 >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #accessing }
ToSelect2 >> addData: aData [

	| idx |
	self data add: aData.
	idx := self data size.
	self dispatchEvent: (ToSelectDataAddedEvent new
			 index: idx;
			 yourself)
]

{ #category : #accessing }
ToSelect2 >> addDataNode: aNode [

	selectFlow addChild: aNode before: selectTextField
]

{ #category : #accessing }
ToSelect2 >> data [

	^ data
]

{ #category : #accessing }
ToSelect2 >> dataNodesDo: aBlock [

	selectFlow childrenDo: [ :child |
		child ~= selectTextField ifTrue: [ aBlock value: child ] ].
]

{ #category : #initialization }
ToSelect2 >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder data asString) ]
]

{ #category : #initialization }
ToSelect2 >> defaultNodeClass [ 

	^ ToSelectNode
]

{ #category : #accessing }
ToSelect2 >> fakeData [

	^ fakeData ifNil: [ fakeData := '' ]
]

{ #category : #accessing }
ToSelect2 >> fakeData: aData [

	fakeData := aData.
	self initializeFakeNode
]

{ #category : #accessing }
ToSelect2 >> icon [

	^ icon
]

{ #category : #accessing }
ToSelect2 >> icon: anElement [

	anElement = self icon ifTrue: [ ^ self ].
	self icon ifNotNil: [ :s | self icon removeFromParent ].
	icon := anElement.
	anElement ifNil: [ ^ self ].
	self iconContainer addChild: anElement
]

{ #category : #accessing }
ToSelect2 >> iconContainer [

	^ iconContainer
]

{ #category : #initialization }
ToSelect2 >> initialize [

	| sharedDistributor |
	super initialize.
	self fitContent.
	self layout beHorizontal.
	data := ToObservableCollection new.
	nodeClass := self defaultNodeClass.
	nodeHolders := OrderedCollection new.
	nodeBuilder := self defaultNodeBuilder.

	" the element that holds the flow"
	contentElement := self newContentElement.
	" the flow element taht contains nodes + the text field "
	selectFlow := self newSelectFlow.

	" the text field for the select input "
	selectTextField := self newSelectTextField.
	selectTextField requestFocus.
	sharedDistributor := BlSharedEventDistributor new.
	sharedDistributor
		adjustMousePosition: false;
		shareEvents: {
				ToAlbumClientEvent.
				ToListSelectionChangedEvent.
				ToInfiniteSelectionDirtyEvent }.
	selectTextField addEventHandler: sharedDistributor.
	self addEventHandler: sharedDistributor.

	windowManager := ToSelectWindowManager new element: self.
	self listElement addEventHandler: sharedDistributor.
	self data addEventHandler: sharedDistributor.
	selectFlow addChild: selectTextField.
	contentElement addChild: selectFlow.

	iconContainer := self newIconContainer.
	self addChildren: {
			contentElement.
			iconContainer }.

	self initializeFakeNode
]

{ #category : #initialization }
ToSelect2 >> initializeFakeNode [
	" the fake node is added when no data is selected to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeHolder |
	fakeNode := self newNode.
	fakeNode id: #'fake-node'.
	fakeHolder := self newNodeHolder.
	fakeNode selectHolder: fakeHolder.
	fakeHolder
		node: fakeNode;
		data: self fakeData.
	self nodeBuilder value: fakeNode value: fakeHolder.
	fakeNode width: 0.
	self refreshNodes
]

{ #category : #accessing }
ToSelect2 >> listElement [

	^ self windowManager listElement
]

{ #category : #'accessing list' }
ToSelect2 >> listNodeBuilder: aNodeFactory [

	self listElement nodeBuilder: aNodeFactory
]

{ #category : #initialization }
ToSelect2 >> newContentElement [

	^ ToElement new
		  vFitContent;
		  hMatchParent;
		  id: #contentElement;
		  layout: BlLinearLayout horizontal;
		  yourself
]

{ #category : #initialization }
ToSelect2 >> newIconContainer [

	^ ToElement new
		  fitContent;
		  id: #iconContainer;
		  layout: BlFrameLayout new;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : #'accessing selection' }
ToSelect2 >> newNode [

	^ self nodeClass new
]

{ #category : #'accessing selection' }
ToSelect2 >> newNodeHolder [

	^ self nodeHolderClass new
]

{ #category : #skin }
ToSelect2 >> newRawSkin [ 

	^ ToSelectSkin new
]

{ #category : #initialization }
ToSelect2 >> newSelectFlow [

	^ ToElement new
		  vFitContent;
		  hMatchParent;
		  id: #'select-content';
		  layout: BlFlowLayout horizontal;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : #initialization }
ToSelect2 >> newSelectTextField [

	^ ToTextField new
		  vMatchParent;
		  hFitContent;
		  id: #'select-content-textField';
		  constraintsDo: [ :c | c flow vertical alignCenter ];
		  withSaveCapability;
		  withoutEditsFeedback;
		  defaultRawSkin: ToSelectTextFieldSkin new;
		  yourself
]

{ #category : #accessing }
ToSelect2 >> nodeBuilder [

	" see the mutator method  "
	
	^ nodeBuilder
]

{ #category : #accessing }
ToSelect2 >> nodeBuilder: aValuable [

	" builds a select node element from list data. 
	aValuable take the select node element to build as first argument 
	and the select node holder as second argument"
	
	nodeBuilder := aValuable.
	self initializeFakeNode
]

{ #category : #accessing }
ToSelect2 >> nodeClass [ 

	^ nodeClass 
]

{ #category : #accessing }
ToSelect2 >> nodeClass: aNodeClass [

	nodeClass := aNodeClass.
	self initializeFakeNode
]

{ #category : #'accessing selection' }
ToSelect2 >> nodeHolderClass [ 

	^ ToSelectNodeHolder
]

{ #category : #'accessing selection' }
ToSelect2 >> nodeHolders [

	^ nodeHolders
]

{ #category : #'accessing list' }
ToSelect2 >> onListCloseRequest [

	self textField requestFocus
]

{ #category : #'accessing list' }
ToSelect2 >> refreshNodes [ 

	| nodes |
	self dataNodesDo: [ :node | node removeFromParent ].
	self nodeHolders reset.
	nodes := self selectedIndexes collect: [ :idx |
		| node holder selected |
		node := self newNode.
		holder := self newNodeHolder.
		node selectHolder: holder.
		self nodeHolders add: holder.
		selected := self listElement data at: idx.
		holder
			node: node;
			position: (self data indexOf: selected);
			select: self;
			data: selected.
		self nodeBuilder value: node value: holder.
		node ].
	self addAllDataNodes: nodes.
	nodes ifEmpty: [ selectFlow addChild: fakeNode ].
	self selectIndexes: (nodes collect: [:n | n selectHolder position] ).
	self windowManager fitListHeightToContent
]

{ #category : #accessing }
ToSelect2 >> selectDataAt: anIndex [

	self selectIndex: anIndex.
	self refreshNodes
]

{ #category : #'accessing selection' }
ToSelect2 >> selectIndex: anInteger [

	self listElement selectIndex: anInteger
]

{ #category : #'accessing selection' }
ToSelect2 >> selectIndexes: aCollectionOfInteger [

	self listElement selectIndexes: aCollectionOfInteger
]

{ #category : #'accessing selection' }
ToSelect2 >> selectedIndexes [

	^ self listElement selectedIndexes
]

{ #category : #accessing }
ToSelect2 >> textField [

	^ selectTextField 
]

{ #category : #accessing }
ToSelect2 >> windowManager [

	^ windowManager 
]
