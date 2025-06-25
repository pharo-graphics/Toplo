"
I represent the group of tabs of a tab pane. 
"
Class {
	#name : #ToTabPaneHeader,
	#superclass : #ToPane,
	#traits : 'TToCheckableGroupOwner',
	#classTraits : 'TToCheckableGroupOwner classTrait',
	#instVars : [
		'tabsPane',
		'positioningStrategy',
		'tabs',
		'tabRow',
		'startFiller',
		'endFiller',
		'tabRowContainer',
		'startContainer',
		'endContainer'
	],
	#category : #'Toplo-Widget-TabPaneDeprecated-Core'
}

{ #category : #testing }
ToTabPaneHeader class >> isDeprecated [ 

	^ true
]

{ #category : #'add-remove' }
ToTabPaneHeader >> addTab: aTab [

	aTab header: self.
	self tabRow addChild: aTab
]

{ #category : #initialization }
ToTabPaneHeader >> applyPositioning [

	self positioningStrategy applyOn: self tabsPane
]

{ #category : #accessing }
ToTabPaneHeader >> body [

	^ self tabsPane body
]

{ #category : #initialization }
ToTabPaneHeader >> checkableGroupChangedEvent: anEvent [

	anEvent checkedList do: [ :but |  ]
]

{ #category : #initialization }
ToTabPaneHeader >> defaultPositioningStrategy [

	^ ToTabPaneHeaderOnTopLeft new
]

{ #category : #accessing }
ToTabPaneHeader >> endContainer [

	^ endContainer
]

{ #category : #accessing }
ToTabPaneHeader >> endFiller [

	^ endFiller
]

{ #category : #initialization }
ToTabPaneHeader >> initialize [

	super initialize.

	self
		newCheckAction: [ :evt :grp :l |
		self checkableGroupChangedEvent: evt ]
		onGroup: self group.
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

{ #category : #'add-remove' }
ToTabPaneHeader >> onTabAdded: aButton [

	self group register: aButton.
	self tabs add: aButton
]

{ #category : #'add-remove' }
ToTabPaneHeader >> onTabRemoved: aTab [

	| index nextSelected |
	self tabsPane onTabRemoved: aTab.
	aTab header: nil.

	index := aTab isSelected
		         ifTrue: [ self tabs indexOf: aTab ]
		         ifFalse: [ 0 ].

	self tabs remove: aTab.
	aTab checked: false.
	self group unregister: aTab.
	index > 0 ifFalse: [ ^ self ].
	self tabs ifEmpty: [ ^ self ].

	nextSelected := self tabs size < index
		                ifTrue: [ self tabs last ]
		                ifFalse: [ self tabs at: index ].
	nextSelected checked: true
]

{ #category : #accessing }
ToTabPaneHeader >> positioningStrategy [

	^ positioningStrategy ifNil: [ positioningStrategy := self defaultPositioningStrategy ]
]

{ #category : #accessing }
ToTabPaneHeader >> positioningStrategy: anObject [

	positioningStrategy := anObject.
	self applyPositioning 
]

{ #category : #'t - checkable group owner' }
ToTabPaneHeader >> rawGroup: aGroup [

	self shouldNotImplement 
]

{ #category : #'add-remove' }
ToTabPaneHeader >> removeTab: aTab [

	self tabRow removeChild: aTab
]

{ #category : #accessing }
ToTabPaneHeader >> startContainer [

	^ startContainer
]

{ #category : #accessing }
ToTabPaneHeader >> startFiller [

	^ startFiller
]

{ #category : #accessing }
ToTabPaneHeader >> tabRow [

	^ tabRow 
]

{ #category : #accessing }
ToTabPaneHeader >> tabRowContainer [

	^ tabRowContainer
]

{ #category : #accessing }
ToTabPaneHeader >> tabs [ 

	^ tabs
]

{ #category : #accessing }
ToTabPaneHeader >> tabsPane [ 

	^ tabsPane 
]

{ #category : #accessing }
ToTabPaneHeader >> tabsPane: aTabPane [ 

	tabsPane := aTabPane
]
