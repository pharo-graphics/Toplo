Class {
	#name : #ToTabPaneHeaderNew,
	#superclass : #ToPane,
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'tabs',
		'tabRow',
		'tabRowContainer',
		'startContainer',
		'endContainer',
		'vertical',
		'sharedDistributor'
	],
	#category : #'Toplo-Incubator'
}

{ #category : #orientation }
ToTabPaneHeaderNew >> beHorizontal [

	self tabs beHorizontal
]

{ #category : #orientation }
ToTabPaneHeaderNew >> beVertical [

	self tabs beVertical
]

{ #category : #'tabs selection' }
ToTabPaneHeaderNew >> dataEmptinessChangeEvent: anEvent [

	self tabs selectedIndexes ifEmpty: [ self selectIndex: 1 ]
]

{ #category : #initialization }
ToTabPaneHeaderNew >> defaultTabRowNodeBuilder [

	^ [ :node :holder |
	  | tabModel |
	  tabModel := holder data.
	  tabModel buttonBuilder value: node value: holder ]
]

{ #category : #accessing }
ToTabPaneHeaderNew >> endContainer [

	^ endContainer
]

{ #category : #orientation }
ToTabPaneHeaderNew >> horizontal [

	^ self vertical not
]

{ #category : #orientation }
ToTabPaneHeaderNew >> horizontal: aBoolean [

	self vertical: aBoolean not
]

{ #category : #initialization }
ToTabPaneHeaderNew >> initialize [ 

	super initialize.
	tabRowContainer := ToPane new fitContent; yourself.
	tabs := ToListElement new nodeBuilder: self defaultTabRowNodeBuilder; yourself.
	tabs nodeClass: ToTabNode.
	tabs matchParent.
	tabs infinite matchParent.
	tabRowContainer addChild: tabs.
	tabRowContainer matchParent.
	startContainer := ToPane new fitContent; yourself.
	endContainer := ToPane new fitContent; yourself.
	self addChild: startContainer.
	self addChild: tabRowContainer.
	self addChild: endContainer.
	self initializeEventHandler.
	self when: ToListPrimarySelectionChangedEvent do: [ :evt | self tabsSelectionChangedEvent: evt ].
	tabs data when: ToCollectionEmptinessEvent do: [ :evt | self dataEmptinessChangeEvent: evt ]
]

{ #category : #initialization }
ToTabPaneHeaderNew >> initializeEventHandler [

	sharedDistributor := BlSharedEventDistributor new shareEvents:
		                     self sharedEvents yourself.
	self addEventHandler: sharedDistributor.
	self tabs addEventHandler: sharedDistributor.

]

{ #category : #orientation }
ToTabPaneHeaderNew >> orientationChanged [

	self vertical
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ]
]

{ #category : #'tabs selection' }
ToTabPaneHeaderNew >> selectIndex: anInteger [

	self tabs selectIndex: anInteger
]

{ #category : #initialization }
ToTabPaneHeaderNew >> sharedEvents [

	^ { ToListPrimarySelectionChangedEvent. }
]

{ #category : #accessing }
ToTabPaneHeaderNew >> startContainer [

	^ startContainer
]

{ #category : #accessing }
ToTabPaneHeaderNew >> tabRow [

	^ tabRow 
]

{ #category : #accessing }
ToTabPaneHeaderNew >> tabRowContainer [

	^ tabRowContainer
]

{ #category : #accessing }
ToTabPaneHeaderNew >> tabs [ 

	^ tabs
]

{ #category : #'tabs selection' }
ToTabPaneHeaderNew >> tabsSelectionChangedEvent: anEvent [

	anEvent oldSelectedIndexes trace. ' -> ' trace.
	anEvent newSelectedIndexes traceCr.
]

{ #category : #orientation }
ToTabPaneHeaderNew >> vertical [

	^ vertical
]

{ #category : #orientation }
ToTabPaneHeaderNew >> vertical: aBoolean [

	vertical = aBoolean ifTrue: [ ^ self ].
	vertical := aBoolean.
	self orientationChanged

]
