Class {
	#name : #ToBasicButton,
	#superclass : #ToWidget,
	#traits : 'TOBlLayoutResizable',
	#classTraits : 'TOBlLayoutResizable classTrait',
	#instVars : [
		'step'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - space' }
ToBasicButton >> attachSpace [ 

	super attachSpace.
	self startOn: self 	
]

{ #category : #'mouse handlers' }
ToBasicButton >> clickEvent: anEvent [

	self isDisabled ifTrue: [ ^ self ].
	self stepOn: anEvent currentTarget.
	anEvent consumed: true.
	anEvent currentTarget: self.
	self viewModelDo: [ :m | m clickEvent: anEvent].
	self announce: (ToButtonLaunchClickAction new widget: self).
	self announce: (ToButtonActionPerformed new widget: self).

]

{ #category : #initialization }
ToBasicButton >> defaultDresser [

	^ ToBasicButtonDresser new
]

{ #category : #initialization }
ToBasicButton >> defaultViewModel [ 

	^ ToBasicButtonModel new
]

{ #category : #processing }
ToBasicButton >> startOn: aButton [

	step ifNil: [ ^ self ].
	step startOn: aButton
]

{ #category : #processing }
ToBasicButton >> states: aCollectionOfStates [

	| curr states |
	step := nil.
	aCollectionOfStates ifEmpty: [ ^self ].
	states := aCollectionOfStates copy asOrderedCollection.
	step := states removeFirst. 
	curr := step.
	[ states isEmpty ] whileFalse: [ 
		curr next: states removeFirst.
		curr := curr next ].
	curr next: step.
]

{ #category : #processing }
ToBasicButton >> stepOn: aButton [

	step ifNil: [ ^ self ].
	step applyOn: aButton.
	step := step next
]

{ #category : #'api-  action' }
ToBasicButton >> whenActionPerformedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonActionPerformed do: aBlock
]

{ #category : #'api-  action' }
ToBasicButton >> whenClickedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonLaunchClickAction do: aBlock
]
