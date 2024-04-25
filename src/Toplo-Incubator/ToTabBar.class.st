Class {
	#name : #ToTabBar,
	#superclass : #ToPane,
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'tabs',
		'tabRow',
		'tabRowContainer',
		'startContainer',
		'endContainer',
		'vertical'
	],
	#category : #'Toplo-Incubator'
}

{ #category : #'t - orientable - orientation' }
ToTabBar >> beHorizontal [

	super beHorizontal.
	self tabs beHorizontal
]

{ #category : #'t - orientable - orientation' }
ToTabBar >> beVertical [

	super beVertical.
	self tabs beVertical
]

{ #category : #'tabs selection' }
ToTabBar >> dataEmptinessChangeEvent: anEvent [

	self tabs selectionModel ifEmpty: [ self selectIndex: 1 ]
]

{ #category : #initialization }
ToTabBar >> defaultTabRowNodeBuilder [

	^ [ :node :holder |
	  | tabModel |
	  tabModel := holder dataItem.
	  tabModel buttonBuilder value: node value: holder ]
]

{ #category : #accessing }
ToTabBar >> endContainer [

	^ endContainer
]

{ #category : #orientation }
ToTabBar >> horizontal [

	^ self vertical not
]

{ #category : #orientation }
ToTabBar >> horizontal: aBoolean [

	self vertical: aBoolean not
]

{ #category : #initialization }
ToTabBar >> initialize [

	super initialize.
	tabRowContainer := ToPane new
		                   fitContent;
		                   yourself.
	tabs := ToListElement new
		        nodeBuilder: self defaultTabRowNodeBuilder;
		        yourself.
	tabs nodeFactory: [ ToTabNode new ].
	tabs matchParent.
	tabs infinite matchParent.
	tabRowContainer addChild: tabs.
	tabRowContainer matchParent.
	startContainer := ToPane new
		                  fitContent;
		                  yourself.
	endContainer := ToPane new
		                fitContent;
		                yourself.
	self addChild: startContainer.
	self addChild: tabRowContainer.
	self addChild: endContainer.
	tabs
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :evt | self tabsSelectionChangedEvent: evt ].
	tabs dataAccessor
		addEventHandlerOn: ToCollectionEmptinessEvent
		do: [ :evt | self dataEmptinessChangeEvent: evt ]
]

{ #category : #orientation }
ToTabBar >> orientationChanged [

	self vertical
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ]
]

{ #category : #'tabs selection' }
ToTabBar >> selectIndex: anInteger [

	self tabs selecter selectIndex: anInteger
]

{ #category : #initialization }
ToTabBar >> sharedEvents [

	^ { ToListPrimarySelectionChangedEvent. }
]

{ #category : #accessing }
ToTabBar >> startContainer [

	^ startContainer
]

{ #category : #accessing }
ToTabBar >> tabRow [

	^ tabRow 
]

{ #category : #accessing }
ToTabBar >> tabRowContainer [

	^ tabRowContainer
]

{ #category : #accessing }
ToTabBar >> tabs [ 

	^ tabs
]

{ #category : #'tabs selection' }
ToTabBar >> tabsSelectionChangedEvent: anEvent [

	anEvent selectionModel selectedIndexes traceCr.
]

{ #category : #orientation }
ToTabBar >> vertical [

	^ vertical
]

{ #category : #orientation }
ToTabBar >> vertical: aBoolean [

	vertical = aBoolean ifTrue: [ ^ self ].
	vertical := aBoolean.
	self orientationChanged

]
