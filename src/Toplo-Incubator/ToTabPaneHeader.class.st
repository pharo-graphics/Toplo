Class {
	#name : 'ToTabPaneHeader',
	#superclass : 'ToPane',
	#instVars : [
		'tabsPane',
		'group',
		'positioningStrategy',
		'tabs',
		'tabsContainer'
	],
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'add-remove' }
ToTabPaneHeader >> addTab: aTab [

	aTab header: self.
	self tabsContainer addChild: aTab
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
ToTabPaneHeader >> group [

	^ group
]

{ #category : 'initialization' }
ToTabPaneHeader >> initialize [ 

	super initialize.
	group := ToCheckableGroup new.
	group when: ToCheckableGroupChangedEvent do: [ :event | self checkableGroupChangedEvent: event ].
	tabs := OrderedCollection new.
	tabsContainer := ToPane horizontal fitContent.
	self addChild: tabsContainer
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

	self tabsContainer removeChild: aTab
]

{ #category : 'accessing' }
ToTabPaneHeader >> tabs [ 

	^ tabs
]

{ #category : 'accessing' }
ToTabPaneHeader >> tabsContainer [

	^ tabsContainer 
]

{ #category : 'accessing' }
ToTabPaneHeader >> tabsPane [ 

	^ tabsPane 
]

{ #category : 'accessing' }
ToTabPaneHeader >> tabsPane: aTabPane [ 

	tabsPane := aTabPane
]
