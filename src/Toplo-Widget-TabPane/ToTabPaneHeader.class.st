Class {
	#name : 'ToTabPaneHeader',
	#superclass : 'ToPane',
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
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'orientation' }
ToTabPaneHeader >> beHorizontal [

	self tabs beHorizontal
]

{ #category : 'orientation' }
ToTabPaneHeader >> beVertical [

	self tabs beVertical
]

{ #category : 'tabs selection' }
ToTabPaneHeader >> dataEmptinessChangeEvent: anEvent [

	self tabs selectionIndexes ifEmpty: [ self selectIndex: 1 ]
]

{ #category : 'initialization' }
ToTabPaneHeader >> defaultTabRowNodeBuilder [

	^ [ :node :holder |
	  | tabModel |
	  tabModel := holder data.
	  tabModel buttonBuilder value: node value: holder ]
]

{ #category : 'accessing' }
ToTabPaneHeader >> endContainer [

	^ endContainer
]

{ #category : 'orientation' }
ToTabPaneHeader >> horizontal [

	^ self vertical not
]

{ #category : 'orientation' }
ToTabPaneHeader >> horizontal: aBoolean [

	self vertical: aBoolean not
]

{ #category : 'initialization' }
ToTabPaneHeader >> initialize [ 

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
	self when: ToInfiniteSelectionChangedEvent do: [ :evt | self tabsSelectionChangedEvent: evt ].
	tabs data when: ToDataEmptinessChangeEvent do: [ :evt | self dataEmptinessChangeEvent: evt ]
]

{ #category : 'initialization' }
ToTabPaneHeader >> initializeEventHandler [

	sharedDistributor := BlSharedEventDistributor new shareEvents:
		                     self sharedEvents yourself.
	self addEventHandler: sharedDistributor.
	self tabs addEventHandler: sharedDistributor.

]

{ #category : 'orientation' }
ToTabPaneHeader >> orientationChanged [

	self vertical
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ]
]

{ #category : 'tabs selection' }
ToTabPaneHeader >> selectIndex: anInteger [

	self tabs selectIndex: anInteger
]

{ #category : 'initialization' }
ToTabPaneHeader >> sharedEvents [

	^ { ToInfiniteSelectionChangedEvent. }
]

{ #category : 'accessing' }
ToTabPaneHeader >> startContainer [

	^ startContainer
]

{ #category : 'accessing' }
ToTabPaneHeader >> tabRow [

	^ tabRow 
]

{ #category : 'accessing' }
ToTabPaneHeader >> tabRowContainer [

	^ tabRowContainer
]

{ #category : 'accessing' }
ToTabPaneHeader >> tabs [ 

	^ tabs
]

{ #category : 'tabs selection' }
ToTabPaneHeader >> tabsSelectionChangedEvent: anEvent [

	anEvent oldSelectedIndexes trace. ' -> ' trace.
	anEvent newSelectedIndexes traceCr.
]

{ #category : 'orientation' }
ToTabPaneHeader >> vertical [

	^ vertical
]

{ #category : 'orientation' }
ToTabPaneHeader >> vertical: aBoolean [

	vertical = aBoolean ifTrue: [ ^ self ].
	vertical := aBoolean.
	self orientationChanged

]
