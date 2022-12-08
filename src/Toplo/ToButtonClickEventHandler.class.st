Class {
	#name : #ToButtonClickEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'button'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #accessing }
ToButtonClickEventHandler >> button [

	^ button
]

{ #category : #accessing }
ToButtonClickEventHandler >> button: aButton [

	button := aButton
]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> clickCandidateEvent: anEvent [

	"then try to manage hidden click "

	| mup |
	anEvent consumed: true.
	mup := anEvent mouseUpEvent.
	mup ifNil: [ ^self ].
	anEvent modifiers isEmpty ifFalse: [ ^ self ].
	(mup currentTarget == button or: [ 
		 mup currentTarget hasParent: button ]) ifTrue: [ 
		button dispatchEvent: mup asClickEvent ]
]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> clickEvent: anEvent [

	anEvent modifiers isEmpty ifFalse: [ ^ self ].
	anEvent isConsumed ifTrue: [ ^ self ].
	anEvent consumed: true.
	button isDisabled ifTrue: [ ^ self ].
	button announce: (ToButtonClickLaunchAction new widget: button)
]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> doubleClickEvent: anEvent [

	anEvent modifiers isEmpty ifFalse: [ ^ self ].
	anEvent consumed: true.
	self clickEvent: anEvent
]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> eventsToHandle [

	^ { BlClickEvent. BlDoubleClickEvent. BlMouseDownEvent. BlMouseUpEvent. BlClickCandidateEvent }
]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> mouseDownEvent: anEvent [


	anEvent consumed: true
]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> mouseUpEvent: anEvent [

	"Because of the button has sub-elements, a Mouse up can have a different target than the corresponding mouse down but it can come from the button or from one of its children (if mouse has slided from the label to the icon as an example)"

	"mouse up must be consumed here so that BlClickCandidateEvent is created with the right BlMouseUpEvent"

	anEvent consumed: true
]
