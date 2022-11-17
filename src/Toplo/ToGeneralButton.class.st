Class {
	#name : #ToGeneralButton,
	#superclass : #ToWidget,
	#traits : 'TBlAlignable + TOBlLayoutResizable',
	#classTraits : 'TBlAlignable classTrait + TOBlLayoutResizable classTrait',
	#instVars : [
		'clickHandler',
		'state'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - space' }
ToGeneralButton >> attachSpace [ 

	super attachSpace.

	clickHandler := ToButtonClickEventHandler new button: self.
	self addEventHandler: clickHandler.

	self startOn: self 	
]

{ #category : #'api - change hook' }
ToGeneralButton >> changeToStateNamed: aStateName [

	| found |
	found := self stateNamed: aStateName.
	found ifNil: [ ^ self ].
	found = state ifTrue: [ ^ self ].
	state exitOn: self nextState: found.
	state := found
]

{ #category : #'mouse handlers' }
ToGeneralButton >> clickEvent: anEvent [

	self isDisabled ifTrue: [ ^ self ].
	self stepOn: anEvent currentTarget.
	anEvent consumed: true.
	anEvent currentTarget: self.
	self viewModelDo: [ :m | m clickEvent: anEvent].
	self announce: (ToButtonClickLaunchAction new widget: self).
	self announce: (ToButtonClickActionPerformed new widget: self).

]

{ #category : #initialization }
ToGeneralButton >> defaultDresser [

	^ ToButtonDefaultDresser new
]

{ #category : #initialization }
ToGeneralButton >> defaultViewModel [ 

	^ ToGeneralButtonModel new
]

{ #category : #'api - space' }
ToGeneralButton >> detachSpace [ 

	self removeEventHandler: clickHandler.
	clickHandler := nil.
	
	super detachSpace.

]

{ #category : #accessing }
ToGeneralButton >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #accessing }
ToGeneralButton >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #initialization }
ToGeneralButton >> initialize [ 

	super initialize.

]

{ #category : #'state processing' }
ToGeneralButton >> startOn: aButton [

	state ifNil: [ ^ self ].
	state startOn: aButton
]

{ #category : #'state processing' }
ToGeneralButton >> stateNamed: anObject [

	| curr |
	state ifNil: [ ^ nil ].
	curr := state.
	[ 
	curr name = anObject ifTrue: [ ^ curr ].
	curr := curr next.
	curr = state ] whileFalse: [  ]
]

{ #category : #'state processing' }
ToGeneralButton >> states: aCollectionOfStates [

	| curr states |
	state := nil.
	aCollectionOfStates ifEmpty: [ ^self ].
	states := aCollectionOfStates copy asOrderedCollection.
	state := states removeFirst. 
	curr := state.
	[ states isEmpty ] whileFalse: [ 
		curr next: states removeFirst.
		curr := curr next ].
	curr next: state.
]

{ #category : #'state processing' }
ToGeneralButton >> stepOn: aButton [

	state ifNil: [ ^ self ].
	state applyOn: aButton.
	state := state next
]

{ #category : #accessing }
ToGeneralButton >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment 
]

{ #category : #accessing }
ToGeneralButton >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]

{ #category : #'api-  action' }
ToGeneralButton >> whenActionPerformedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonClickActionPerformed do: aBlock
]

{ #category : #'api-  action' }
ToGeneralButton >> whenClickedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonClickLaunchAction do: aBlock
]

{ #category : #'api - change hook' }
ToGeneralButton >> whenStateChangedDo: aBlock [
	"Inform when the current state has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new state
	 - old state"

	self property: #state whenChangedDo: aBlock
]
