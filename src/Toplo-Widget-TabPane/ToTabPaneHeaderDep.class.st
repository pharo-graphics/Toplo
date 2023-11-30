Class {
	#name : 'ToTabPaneHeaderDep',
	#superclass : 'ToPane',
	#instVars : [
		'tabsPane',
		'group',
		'positioningStrategy',
		'tabs',
		'tabRow',
		'tabRowContainer',
		'startContainer',
		'endContainer'
	],
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'add-remove' }
ToTabPaneHeaderDep >> addTab: aTab [

	aTab header: self.
	self tabRow addChild: aTab
]

{ #category : 'initialization' }
ToTabPaneHeaderDep >> applyPositioning [

	self positioningStrategy applyOn: self tabsPane
]

{ #category : 'accessing' }
ToTabPaneHeaderDep >> body [

	^ self tabsPane body
]

{ #category : 'initialization' }
ToTabPaneHeaderDep >> checkableGroupChangedEvent: anEvent [

	anEvent uncheckedButtons do: [ :but | ].
	anEvent checkedButtons do: [ :but | ].
]

{ #category : 'accessing' }
ToTabPaneHeaderDep >> checkingStrategy [

	^ self group checkingStrategy
]

{ #category : 'accessing' }
ToTabPaneHeaderDep >> checkingStrategy: aCheckingStrategy [

	^ self group checkingStrategy: aCheckingStrategy
]

{ #category : 'initialization' }
ToTabPaneHeaderDep >> defaultPositioningStrategy [

	^ ToTabPaneHeaderOnTopLeft new
]

{ #category : 'accessing' }
ToTabPaneHeaderDep >> endContainer [

	^ endContainer
]

{ #category : 'accessing' }
ToTabPaneHeaderDep >> group [

	^ group
]

{ #category : 'initialization' }
ToTabPaneHeaderDep >> initialize [ 

	super initialize.
	group := ToCheckableGroup new.
	group when: ToCheckableGroupChangedEvent do: [ :event | self checkableGroupChangedEvent: event ].
	tabs := OrderedCollection new.
	tabRowContainer := ToPane new vFitContent; hMatchParent; yourself.
	tabRow := ToPane horizontal hMatchParent; yourself.
	tabRowContainer addChild: tabRow.
	startContainer := ToPane new vMatchParent; hFitContent; yourself.
	endContainer := ToPane new vMatchParent; hFitContent; yourself.
	self addChild: startContainer.
	self addChild: tabRowContainer.
	self addChild: endContainer.

]

{ #category : 'add-remove' }
ToTabPaneHeaderDep >> onTabAdded: aButton [

	self group add: aButton.
	self tabs add: aButton.
	
]

{ #category : 'add-remove' }
ToTabPaneHeaderDep >> onTabRemoved: aTab [

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
ToTabPaneHeaderDep >> positioningStrategy [

	^ positioningStrategy ifNil: [ positioningStrategy := self defaultPositioningStrategy ]
]

{ #category : 'accessing' }
ToTabPaneHeaderDep >> positioningStrategy: anObject [

	positioningStrategy := anObject.
	self applyPositioning 
]

{ #category : 'add-remove' }
ToTabPaneHeaderDep >> removeTab: aTab [

	self tabRow removeChild: aTab
]

{ #category : 'accessing' }
ToTabPaneHeaderDep >> startContainer [

	^ startContainer
]

{ #category : 'accessing' }
ToTabPaneHeaderDep >> tabRow [

	^ tabRow 
]

{ #category : 'accessing' }
ToTabPaneHeaderDep >> tabRowContainer [

	^ tabRowContainer
]

{ #category : 'accessing' }
ToTabPaneHeaderDep >> tabs [ 

	^ tabs
]

{ #category : 'accessing' }
ToTabPaneHeaderDep >> tabsPane [ 

	^ tabsPane 
]

{ #category : 'accessing' }
ToTabPaneHeaderDep >> tabsPane: aTabPane [ 

	tabsPane := aTabPane
]
