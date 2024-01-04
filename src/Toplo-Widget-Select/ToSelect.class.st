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
		'selectFlow'
	],
	#category : #'Toplo-Widget-Select'
}

{ #category : #accessing }
ToSelect >> data [

	^ self listElement data
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
		shareEvents: { ToAlbumClientEvent. "ToListSelectionChangedEvent"  }.
	selectTextField addEventHandler: sharedDistributor.
	self addEventHandler: sharedDistributor.
	"self listElement addEventHandler: sharedDistributor."
	self listElement addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :evt | self enqueueTask: (BlTaskAction new action: [self onIndexesSelectedInList: self listElement selectedIndexes ])]).

	selectFlow addChild: selectTextField.
	contentElement addChild: selectFlow.

	iconContainer := self newIconContainer.
	self addChildren: {
			contentElement.
			iconContainer }.
	

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
	
	nodeBuilder := aValuable
]

{ #category : #accessing }
ToSelect >> nodeClass [ 

	^ nodeClass 
]

{ #category : #accessing }
ToSelect >> nodeClass: aNodeClass [

	nodeClass := aNodeClass
]

{ #category : #'accessing selection' }
ToSelect >> nodeHolderClass [ 

	^ ToSelectNodeHolder
]

{ #category : #'accessing selection' }
ToSelect >> nodeHolders [

	^ nodeHolders
]

{ #category : #'accessing selection' }
ToSelect >> onIndexesSelectedInList: aCollectionOfInteger [

	selectFlow childrenDo: [ :child |
		child ~= selectTextField ifTrue: [ child removeFromParent ] ].
	self nodeHolders reset.
	aCollectionOfInteger do: [ :idx |
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
		selectFlow addChild: node before: selectTextField ]
]

{ #category : #'accessing list' }
ToSelect >> onListCloseRequest [

	self textField requestFocus
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
