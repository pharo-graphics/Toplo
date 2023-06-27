Class {
	#name : #ToButtonClickHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'button'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #accessing }
ToButtonClickHandler >> button [

	^ button
]

{ #category : #accessing }
ToButtonClickHandler >> button: aButton [

	button := aButton
]

{ #category : #'api - accessing' }
ToButtonClickHandler >> clickCandidateEvent: anEvent [

	"then try to manage hidden click "

	| mup |
	anEvent consumed: true.
	mup := anEvent mouseUpEvent.
	mup ifNil: [ ^ self ].
	anEvent modifiers isEmpty ifFalse: [ ^ self ].
	(mup currentTarget hasInParentChain: button) ifTrue: [ 
		button dispatchEvent: mup asClickEvent ]
]

{ #category : #'api - accessing' }
ToButtonClickHandler >> clickEvent: anEvent [

	| clickEvent |
	button isDisabled ifTrue: [ ^ self ].
	anEvent consumed: true.
	clickEvent := anEvent secondaryButtonPressed
		              ifTrue: [ ToRightClickEvent new ]
		              ifFalse: [ ToLeftClickEvent new ].
	button dispatchEvent: clickEvent
]

{ #category : #'api - accessing' }
ToButtonClickHandler >> doubleClickEvent: anEvent [

	" double click on a button is managed as a click  "
	anEvent modifiers isEmpty ifFalse: [ ^ self ].
	anEvent consumed: true.
	button dispatchEvent: anEvent asClickEvent
]

{ #category : #'api - accessing' }
ToButtonClickHandler >> eventsToHandle [

	^ { BlClickEvent. BlDoubleClickEvent. BlMouseDownEvent. BlMouseUpEvent. BlClickCandidateEvent }
]

{ #category : #'api - accessing' }
ToButtonClickHandler >> mouseDownEvent: anEvent [

	" do not consume here to allow right click "
	"anEvent consumed: true"
]

{ #category : #'api - accessing' }
ToButtonClickHandler >> mouseUpEvent: anEvent [

	"Because of the button has sub-elements, a Mouse up can have a different target than the corresponding mouse down but it can come from the button or from one of its children (if mouse has slided from the label to the icon as an example)"

	"mouse up must be consumed here so that BlClickCandidateEvent is created with the right BlMouseUpEvent"

	anEvent consumed: true
]
