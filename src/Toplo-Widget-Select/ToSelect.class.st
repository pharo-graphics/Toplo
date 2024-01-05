Class {
	#name : #ToSelect,
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
		'fakeNode'
	],
	#category : #'Toplo-Widget-Select'
}

{ #category : #accessing }
ToSelect >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #accessing }
ToSelect >> addData: aData [

	| idx |
	self data add: aData.
	idx := self data size.
	self dispatchEvent: (ToSelectDataAddedEvent new
			 index: idx;
			 yourself)
]

{ #category : #accessing }
ToSelect >> addDataNode: aNode [

	selectFlow addChild: aNode before: selectTextField
]

{ #category : #accessing }
ToSelect >> data [

	^ self listElement data
]

{ #category : #accessing }
ToSelect >> dataNodesDo: aBlock [

	selectFlow childrenDo: [ :child |
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

{ #category : #accessing }
ToSelect >> fakeData [

	^ fakeData ifNil: [ fakeData := '' ]
]

{ #category : #accessing }
ToSelect >> fakeData: aData [

	fakeData := aData.
	self initializeFakeNode
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

	| sharedDistributor |
	super initialize.
	self fitContent.
	self layout beHorizontal.
	nodeClass := self defaultNodeClass.
	nodeHolders := OrderedCollection new.
	nodeBuilder := self defaultNodeBuilder.
	
	" the element that holds the flow"
	contentElement := self newContentElement.
	" the flow element taht contains nodes + the text field "
	selectFlow := self newSelectFlow.

	windowManager := ToSelectWindowManager new element: self.
	
	" the text field for the select input "
	selectTextField := self newSelectTextField.
	selectTextField requestFocus.
	sharedDistributor := BlSharedEventDistributor new.
	sharedDistributor
		adjustMousePosition: false;
		shareEvents: { ToAlbumClientEvent. ToListSelectionChangedEvent. ToInfiniteSelectionDirtyEvent   }.
	selectTextField addEventHandler: sharedDistributor.
	self addEventHandler: sharedDistributor.
	self listElement addEventHandler: sharedDistributor.
	selectFlow addChild: selectTextField.
	contentElement addChild: selectFlow.

	iconContainer := self newIconContainer.
	self addChildren: {
			contentElement.
			iconContainer }.
			
	self initializeFakeNode.
	
	

]

{ #category : #initialization }
ToSelect >> initializeFakeNode [
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
ToSelect >> listElement [

	^ self windowManager listElement
]

{ #category : #'accessing list' }
ToSelect >> listNodeBuilder: aNodeFactory [

	self listElement nodeBuilder: aNodeFactory
]

{ #category : #initialization }
ToSelect >> newContentElement [

	^ ToElement new
		  vFitContent;
		  hMatchParent;
		  id: #contentElement;
		  layout: BlLinearLayout horizontal;
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

{ #category : #'accessing selection' }
ToSelect >> newNode [

	^ self nodeClass new
]

{ #category : #'accessing selection' }
ToSelect >> newNodeHolder [

	^ self nodeHolderClass new
]

{ #category : #skin }
ToSelect >> newRawSkin [ 

	^ ToSelectSkin new
]

{ #category : #initialization }
ToSelect >> newSelectFlow [

	^ ToElement new
		  vFitContent;
		  hMatchParent;
		  id: #'select-content';
		  layout: BlFlowLayout horizontal;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : #initialization }
ToSelect >> newSelectTextField [

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

{ #category : #'accessing selection' }
ToSelect >> nodeHolderClass [ 

	^ ToSelectNodeHolder
]

{ #category : #'accessing selection' }
ToSelect >> nodeHolders [

	^ nodeHolders
]

{ #category : #'accessing list' }
ToSelect >> onListCloseRequest [

	self textField requestFocus
]

{ #category : #'accessing list' }
ToSelect >> refreshNodes [ 

	| nodes |
	self dataNodesDo: [ :node | node removeFromParent ].
	self nodeHolders reset.
	nodes := self selectedIndexes collect: [ :idx |
		| node holder |
		node := self newNode.
		holder := self newNodeHolder.
		node selectHolder: holder.
		self nodeHolders add: holder.
		holder
			node: node;
			position: idx;
			select: self;
			data: (self data at: idx).
		self nodeBuilder value: node value: holder.
		node ].
	self addAllDataNodes: nodes.
	nodes ifEmpty: [ selectFlow addChild: fakeNode ].
	self windowManager fitListHeightToContent
]

{ #category : #accessing }
ToSelect >> selectDataAt: anIndex [

	self selectIndex: anIndex.
	self refreshNodes
]

{ #category : #'accessing selection' }
ToSelect >> selectIndex: anInteger [

	self listElement selectIndex: anInteger
]

{ #category : #'accessing selection' }
ToSelect >> selectIndexes: aCollectionOfInteger [

	self listElement selectIndexes: aCollectionOfInteger
]

{ #category : #'accessing selection' }
ToSelect >> selectedIndexes [

	^ self listElement selectedIndexes
]

{ #category : #accessing }
ToSelect >> textField [

	^ selectTextField 
]

{ #category : #accessing }
ToSelect >> windowManager [

	^ windowManager 
]
