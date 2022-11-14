Class {
	#name : #ToBasicButtonEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'button'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #accessing }
ToBasicButtonEventHandler >> button [

	^ button
]

{ #category : #accessing }
ToBasicButtonEventHandler >> button: aButton [

	button := aButton
]

{ #category : #'api - accessing' }
ToBasicButtonEventHandler >> clickCandidateEvent: anEvent [

	"then try to manage hidden click "

	| mup |
	mup := anEvent mouseUpEvent.
	(mup currentTarget == button or: [ 
		 mup currentTarget hasParent: button ]) ifTrue: [ 
		button dispatchEvent: mup asClickEvent ]
]

{ #category : #'api - accessing' }
ToBasicButtonEventHandler >> clickEvent: anEvent [

	button clickEvent: anEvent
]

{ #category : #'api - accessing' }
ToBasicButtonEventHandler >> doubleClickEvent: anEvent [

	button clickEvent: anEvent
]

{ #category : #'api - accessing' }
ToBasicButtonEventHandler >> eventsToHandle [
	^ { BlClickEvent. BlDoubleClickEvent. BlMouseUpEvent. BlClickCandidateEvent}
]

{ #category : #'api - accessing' }
ToBasicButtonEventHandler >> mouseUpEvent: anEvent [

	"Because of the button has sub-elements, a Mouse up can a different target than the related mouse down but it can come from the button or from one of its children (if mouse has slided from the label to the icon as an example)"

	"mouse up must be consumed here so that BlClickCandidateEvent is created with the right BlMouseUpEvent"

	anEvent consumed: true
]
