Class {
	#name : 'ToTabPaneHeader',
	#superclass : 'ToPane',
	#instVars : [
		'buttons',
		'group'
	],
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'accessing' }
ToTabPaneHeader >> body [

	^ self notebook body
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

{ #category : 'accessing' }
ToTabPaneHeader >> group [

	^ group
]

{ #category : 'initialization' }
ToTabPaneHeader >> initialize [ 

	super initialize.
	group := ToCheckableGroup new.
	group when: ToCheckableGroupChangedEvent do: [ :event | self checkableGroupChangedEvent: event ].
	buttons := OrderedCollection new
]

{ #category : 'accessing' }
ToTabPaneHeader >> notebook [

	^ self parent 
]

{ #category : 'hooks - children' }
ToTabPaneHeader >> onAddedToParent [ 

	super onAddedToParent.
	self parent applyHeaderPositioning 
]

{ #category : 'add-remove' }
ToTabPaneHeader >> onButtonAdded: aButton [

	self group add: aButton.
	self tabs add: aButton.
	
]

{ #category : 'add-remove' }
ToTabPaneHeader >> onTabRemoved: aButton [

	| index nextSelected |
	self notebook onTabRemoved: aButton.
	index := aButton isSelected
		         ifTrue: [ self tabs indexOf: aButton ]
		         ifFalse: [ 0 ].

	self tabs remove: aButton.
	self group remove: aButton.
	index > 0 ifFalse: [ ^ self ].
	self tabs ifEmpty: [ ^ self ].

	nextSelected := self tabs size < index
		                ifTrue: [ self tabs last ]
		                ifFalse: [ self tabs at: index ].
	nextSelected checked: true
]

{ #category : 'accessing' }
ToTabPaneHeader >> tabs [ 

	^ buttons
]
