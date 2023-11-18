Class {
	#name : 'ToNotebookHeader',
	#superclass : 'ToPane',
	#instVars : [
		'buttons',
		'group'
	],
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'accessing' }
ToNotebookHeader >> body [

	^ self parent body
]

{ #category : 'accessing' }
ToNotebookHeader >> buttons [ 

	^ buttons
]

{ #category : 'initialization' }
ToNotebookHeader >> checkableGroupChangedEvent: anEvent [

	anEvent uncheckedButtons do: [ :but | ].
	anEvent checkedButtons do: [ :but | ].
]

{ #category : 'accessing' }
ToNotebookHeader >> group [

	^ group
]

{ #category : 'initialization' }
ToNotebookHeader >> initialize [ 

	super initialize.
	group := ToCheckableGroup new.
	group when: ToCheckableGroupChangedEvent do: [ :event | self checkableGroupChangedEvent: event ].
	buttons := OrderedCollection new
]

{ #category : 'add-remove' }
ToNotebookHeader >> onButonAdded: aButton [

	self buttons add: aButton
]

{ #category : 'add-remove' }
ToNotebookHeader >> onButonRemoved: aButton [

	self buttons remove: aButton
]
