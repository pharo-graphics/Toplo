Class {
	#name : #ToNotebookHeader,
	#superclass : #ToPane,
	#instVars : [
		'buttons',
		'group'
	],
	#category : 'Toplo-Incubator'
}

{ #category : #accessing }
ToNotebookHeader >> body [

	^ self notebook body
]

{ #category : #accessing }
ToNotebookHeader >> buttons [ 

	^ buttons
]

{ #category : #initialization }
ToNotebookHeader >> checkableGroupChangedEvent: anEvent [

	anEvent uncheckedButtons do: [ :but | ].
	anEvent checkedButtons do: [ :but | ].
]

{ #category : #accessing }
ToNotebookHeader >> checkingStrategy [

	^ self group checkingStrategy
]

{ #category : #accessing }
ToNotebookHeader >> checkingStrategy: aCheckingStrategy [

	^ self group checkingStrategy: aCheckingStrategy
]

{ #category : #accessing }
ToNotebookHeader >> group [

	^ group
]

{ #category : #initialization }
ToNotebookHeader >> initialize [ 

	super initialize.
	group := ToCheckableGroup new.
	group when: ToCheckableGroupChangedEvent do: [ :event | self checkableGroupChangedEvent: event ].
	buttons := OrderedCollection new
]

{ #category : #accessing }
ToNotebookHeader >> notebook [

	^ self parent 
]

{ #category : #'hooks - children' }
ToNotebookHeader >> onAddedToParent [ 

	super onAddedToParent.
	self parent applyHeaderPositioning 
]

{ #category : #'add-remove' }
ToNotebookHeader >> onButtonAdded: aButton [

	self group add: aButton.
	self buttons add: aButton.
	
]

{ #category : #'add-remove' }
ToNotebookHeader >> onButtonRemoved: aButton [

	| index nextSelected |
	self notebook onButtonRemoved: aButton.
	index := aButton isSelected
		         ifTrue: [ self buttons indexOf: aButton ]
		         ifFalse: [ 0 ].

	self buttons remove: aButton.
	self group remove: aButton.
	index > 0 ifFalse: [ ^ self ].
	self buttons ifEmpty: [ ^ self ].

	nextSelected := self buttons size < index
		                ifTrue: [ self buttons last ]
		                ifFalse: [ self buttons at: index ].
	nextSelected checked: true
]
