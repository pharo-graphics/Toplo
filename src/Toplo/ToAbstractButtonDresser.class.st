Class {
	#name : #ToAbstractButtonDresser,
	#superclass : #ToMouseHandlingDresser,
	#instVars : [
		'clickCandidateHandler'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'events handling' }
ToAbstractButtonDresser >> clickCandidate: anElement event: anEvent [

	"Manage possible click "
	"Because a button may have sub-elements, a Mouse up can have a different target than the
	corresponding mouse down. It is because a slide can occur if mouse has slided from the 
	label to the icon as an example)"

	| mup |
	anEvent consumed: true.
	mup := anEvent mouseUpEvent.
	mup ifNil: [ ^ self ].
	anEvent modifiers isEmpty ifFalse: [ ^ self ].
	(mup currentTarget hasInParentChain: anElement) ifTrue: [ 
		anElement dispatchEvent: mup asClickEvent ]
]

{ #category : #'event handlers' }
ToAbstractButtonDresser >> clickCandidateHandlerIn: anElement [

	^ BlEventHandler on: BlClickCandidateEvent do: [ :event | self clickCandidate: anElement event: event  ]
]

{ #category : #'events handling' }
ToAbstractButtonDresser >> clicked: anElement event: anEvent [

	| clickEvent |
	super clicked:  anElement event: anEvent.
	anElement isDisabled ifTrue: [ ^ self ].
	clickEvent := anEvent secondaryButtonPressed
		              ifTrue: [ ToRightClickEvent new ]
		              ifFalse: [
			              anEvent middleButtonPressed
				              ifTrue: [ ToMiddleClickEvent new ]
				              ifFalse: [ ToLeftClickEvent new ] ].
	anElement dispatchEvent: clickEvent
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	clickCandidateHandler := self clickCandidateHandlerIn: anElement.
	
	anElement addEventHandler: clickCandidateHandler.


]

{ #category : #'api - install/uninstall  hook' }
ToAbstractButtonDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: clickCandidateHandler
]

{ #category : #'events handling' }
ToAbstractButtonDresser >> up: anElement event: anEvent [

	super up:  anElement event: anEvent.
	"mouse up must be consumed here so that BlClickCandidateEvent is created 
	with the right BlMouseUpEvent"
	anEvent primaryButtonPressed ifFalse: [ ^ self ].
	anEvent consumed: true 
]
