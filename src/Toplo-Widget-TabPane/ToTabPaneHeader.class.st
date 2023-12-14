Class {
	#name : 'ToTabPaneHeader',
	#superclass : 'ToPane',
	#instVars : [
		'tabsPane',
		'group',
		'positioningStrategy',
		'tabs',
		'tabRow',
		'startFiller',
		'endFiller',
		'tabRowContainer',
		'startContainer',
		'endContainer'
	],
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'add-remove' }
ToTabPaneHeader >> addTab: aTab [

	aTab header: self.
	self tabRow addChild: aTab
]

{ #category : 'initialization' }
ToTabPaneHeader >> applyPositioning [

	self positioningStrategy applyOn: self tabsPane
]

{ #category : 'accessing' }
ToTabPaneHeader >> body [

	^ self tabsPane body
]

{ #category : 'initialization' }
ToTabPaneHeader >> checkableGroupChangedEvent: anEvent [

	anEvent uncheckedButtons do: [ :but | ].
	anEvent checkedButtons do: [ :but | ].
]

{ #category : 'accessing' }
ToTabPaneHeader >> checkingStrategy [

	^ self group checkingStrategy
]

{ #category : 'accessing' }
ToTabPaneHeader >> checkingStrategy: aCheckingStrategy [

	^ self group checkingStrategy: aCheckingStrategy
]

{ #category : 'initialization' }
ToTabPaneHeader >> defaultPositioningStrategy [

	^ ToTabPaneHeaderOnTopLeft new
]

{ #category : 'accessing' }
ToTabPaneHeader >> endContainer [

	^ endContainer
]

{ #category : 'accessing' }
ToTabPaneHeader >> endFiller [

	^ endFiller
]

{ #category : 'accessing' }
ToTabPaneHeader >> group [

	^ group
]

{ #category : 'initialization' }
ToTabPaneHeader >> initialize [

	super initialize.
	group := ToCheckableGroup new.
	group addEventHandler: (BlEventHandler
			 on: ToCheckableGroupChangedEvent
			 do: [ :event | self checkableGroupChangedEvent: event ]).
	tabs := OrderedCollection new.
	startFiller := ToElement new.
	endFiller := ToElement new.
	tabRowContainer := ToPane new.
	tabRow := ToPane new fitContent.
	tabRowContainer addChild: startFiller.
	tabRowContainer addChild: tabRow.
	tabRowContainer addChild: endFiller.
	startContainer := ToPane new fitContent.
	endContainer := ToPane new fitContent.
	self addChild: startContainer.
	self addChild: tabRowContainer.
	self addChild: endContainer
]

{ #category : 'add-remove' }
ToTabPaneHeader >> onTabAdded: aButton [

	self group add: aButton.
	self tabs add: aButton.
	
]

{ #category : 'add-remove' }
ToTabPaneHeader >> onTabRemoved: aTab [

	| index nextSelected |
	self tabsPane onTabRemoved: aTab.
	aTab header: nil.

	index := aTab isSelected
		         ifTrue: [ self tabs indexOf: aTab ]
		         ifFalse: [ 0 ].

	self tabs remove: aTab.
	self group remove: aTab.
	index > 0 ifFalse: [ ^ self ].
	self tabs ifEmpty: [ ^ self ].

	nextSelected := self tabs size < index
		                ifTrue: [ self tabs last ]
		                ifFalse: [ self tabs at: index ].
	nextSelected checked: true
]

{ #category : 'accessing' }
ToTabPaneHeader >> positioningStrategy [

	^ positioningStrategy ifNil: [ positioningStrategy := self defaultPositioningStrategy ]
]

{ #category : 'accessing' }
ToTabPaneHeader >> positioningStrategy: anObject [

	positioningStrategy := anObject.
	self applyPositioning 
]

{ #category : 'add-remove' }
ToTabPaneHeader >> removeTab: aTab [

	self tabRow removeChild: aTab
]

{ #category : 'accessing' }
ToTabPaneHeader >> startContainer [

	^ startContainer
]

{ #category : 'accessing' }
ToTabPaneHeader >> startFiller [

	^ startFiller
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

{ #category : 'accessing' }
ToTabPaneHeader >> tabsPane [ 

	^ tabsPane 
]

{ #category : 'accessing' }
ToTabPaneHeader >> tabsPane: aTabPane [ 

	tabsPane := aTabPane
]
