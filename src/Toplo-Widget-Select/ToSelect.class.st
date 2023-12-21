Class {
	#name : 'ToSelect',
	#superclass : 'ToPane',
	#instVars : [
		'windowManager',
		'iconHolder',
		'icon',
		'filler',
		'contentElement',
		'nodeClass',
		'nodeBuilder',
		'nodeHolders'
	],
	#category : 'Toplo-Widget-Select',
	#package : 'Toplo-Widget-Select'
}

{ #category : 'accessing' }
ToSelect >> contentElement [

	^ contentElement 
]

{ #category : 'accessing' }
ToSelect >> currentSelectContentElement [

	^ self contentElement childWithId: #'select-content' ifNone: [  ]
]

{ #category : 'accessing' }
ToSelect >> data [

	^ self listElement data
]

{ #category : 'initialization' }
ToSelect >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode addChild: (ToLabel text: aNodeHolder data asString) ]
]

{ #category : 'accessing' }
ToSelect >> filler [ 

	^ filler
]

{ #category : 'accessing' }
ToSelect >> icon [

	^ icon
]

{ #category : 'accessing' }
ToSelect >> icon: anElement [

	anElement = self icon ifTrue: [ ^ self ].
	self icon ifNotNil: [ :s | self icon removeFromParent ].
	icon := anElement.
	anElement ifNil: [ ^ self ].
	self iconHolder addChild: anElement
]

{ #category : 'accessing' }
ToSelect >> iconHolder [

	^ iconHolder
]

{ #category : 'initialization' }
ToSelect >> initialize [

	super initialize.
	self fitContent.
	self layout beHorizontal.
	nodeHolders := OrderedCollection new.
	nodeBuilder := self defaultNodeBuilder.
	contentElement := self newContentElement.
	filler := self newFiller.
	iconHolder := self newIconHolder.
	self addChildren: { contentElement. filler. iconHolder }.
	windowManager := ToSelectWindowManager new element: self.
	windowManager widthHook: [ :theWindow :theElement |
		theElement measuredWidth ].
	windowManager heightHook: [ :theWindow :theElement | 400 ]
]

{ #category : 'accessing' }
ToSelect >> listElement [

	^ self windowManager listElement
]

{ #category : 't - infinite accessing' }
ToSelect >> listNodeBuilder: aNodeFactory [

	self listElement nodeBuilder: aNodeFactory
]

{ #category : 'initialization' }
ToSelect >> newContentElement [

	^ ToElement new
		  vFitContent;
		  hMatchParent;
		  id: #contentElement;
		  layout: BlLinearLayout horizontal;
		  yourself
]

{ #category : 'initialization' }
ToSelect >> newFiller [

	^ ToElement new
		  matchParent;
		  id: #'select-filler';
		  yourself
]

{ #category : 'initialization' }
ToSelect >> newIconHolder [

	^ ToElement new
		  fitContent;
		  id: #iconHolder;
		  layout: BlFrameLayout new;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : 'accessing selection' }
ToSelect >> newNode [

	^ self nodeClass new
]

{ #category : 'accessing selection' }
ToSelect >> newNodeHolder [

	^ self nodeHolderClass new
]

{ #category : 'skin' }
ToSelect >> newRawSkin [ 

	^ ToSelectSkin new
]

{ #category : 'accessing' }
ToSelect >> newSelectContentElement [

	^ ToElement new
		  vFitContent;
		  hMatchParent;
		  id: #'select-content';
		  layout: BlFlowLayout horizontal;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : 'accessing' }
ToSelect >> nodeBuilder [

	" see the mutator method  "
	
	^ nodeBuilder
]

{ #category : 'accessing' }
ToSelect >> nodeBuilder: aValuable [

	" builds a select node element from list data. 
	aValuable take the select node element to build as first argument 
	and the select node holder as second argument"
	
	nodeBuilder := aValuable
]

{ #category : 'accessing' }
ToSelect >> nodeClass [ 

	^ nodeClass ifNil: [nodeClass := ToSelectNode]
]

{ #category : 'accessing' }
ToSelect >> nodeClass: aNodeClass [

	nodeClass := aNodeClass
]

{ #category : 'accessing selection' }
ToSelect >> nodeHolderClass [ 

	^ ToSelectNodeHolder
]

{ #category : 'accessing selection' }
ToSelect >> nodeHolders [

	^ nodeHolders
]

{ #category : 'accessing selection' }
ToSelect >> selectIndexes: aCollectionOfInteger [

	| selectContent |
	aCollectionOfInteger
		ifEmpty: [ self filler matchParent ]
		ifNotEmpty: [ self filler size: 0 @ 0 ].
	self currentSelectContentElement ifNotNil: [ :child |
		child removeFromParent ].
	selectContent := self newSelectContentElement.
	self contentElement addChild: selectContent at: 1.
	self nodeHolders reset.
	aCollectionOfInteger do: [ :idx |
		| node holder |
		node := self newNode.
		holder := self newNodeHolder.
		self nodeHolders add: holder.
		holder
			node: node;
			position: idx;
			select: self;
			data: (self data at: idx).
		self nodeBuilder value: node value: holder.
		selectContent addChild: node ]
]

{ #category : 'accessing' }
ToSelect >> windowManager [

	^ windowManager 
]

{ #category : 'accessing' }
ToSelect >> windowManager: anObject [

	windowManager := anObject
]
