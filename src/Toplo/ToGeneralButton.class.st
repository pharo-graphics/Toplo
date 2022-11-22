Class {
	#name : #ToGeneralButton,
	#superclass : #ToWidget,
	#traits : 'TBlAlignable + TOBlLayoutResizable',
	#classTraits : 'TBlAlignable classTrait + TOBlLayoutResizable classTrait',
	#instVars : [
		'#clickHandler',
		'#toggleState => ObservableSlot'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'processing - toggle state' }
ToGeneralButton >> applyStartToggleState [

	toggleState ifNil: [ ^ self ].
	toggleState applyStartStateOn: self
]

{ #category : #'processing - toggle state' }
ToGeneralButton >> applyToggleStateTransition [

	toggleState ifNil: [ ^ self ].
	toggleState applyStateTransitionOn: self.
	toggleState := toggleState next
]

{ #category : #'api - space' }
ToGeneralButton >> attachSpace [ 

	super attachSpace.

	clickHandler := ToButtonClickEventHandler new button: self.
	self addEventHandler: clickHandler.

	self applyStartToggleState
]

{ #category : #'api - change hook' }
ToGeneralButton >> changeToToggleStateNamed: aStateName [

	| found |
	found := self toggleStateNamed: aStateName.
	found ifNil: [ ^ self ].
	found = toggleState ifTrue: [ ^ self ].
	toggleState exitOn: self nextState: found.
	toggleState := found
]

{ #category : #'mouse handlers' }
ToGeneralButton >> clickEvent: anEvent [

	self isDisabled ifTrue: [ ^ self ].
	self applyToggleStateTransition.
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

	self class initializeSlots: self.
	super initialize

]

{ #category : #'accessing - toggle state' }
ToGeneralButton >> toggleStateNamed: anObject [

	| curr |
	toggleState ifNil: [ ^ nil ].
	curr := toggleState.
	[ 
	curr name = anObject ifTrue: [ ^ curr ].
	curr := curr next.
	curr = toggleState ] whileFalse: [  ]
]

{ #category : #'accessing - toggle state' }
ToGeneralButton >> toggleStates: aCollectionOfStates [

	| curr states |
	toggleState := nil.
	aCollectionOfStates ifEmpty: [ ^self ].
	states := aCollectionOfStates copy asOrderedCollection.
	toggleState := states removeFirst. 
	curr := toggleState.
	[ states isEmpty ] whileFalse: [ 
		curr next: states removeFirst.
		curr := curr next ].
	curr next: toggleState.
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

{ #category : #'api - change hook' }
ToGeneralButton >> whenChangedDo: aBlock [
	"Inform when the current state has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new state
	 - old state"

	self property: #toggleState whenChangedDo: aBlock
]

{ #category : #'api-  action' }
ToGeneralButton >> whenClickedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonClickLaunchAction do: aBlock
]
