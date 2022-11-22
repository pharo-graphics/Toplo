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
	(mup currentTarget == button or: [ 
		 mup currentTarget hasParent: button ]) ifTrue: [ 
		button dispatchEvent: mup asClickEvent ]
]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> clickEvent: anEvent [

	anEvent consumed: true.
	anEvent currentTarget clickEvent: anEvent
]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> doubleClickEvent: anEvent [

	anEvent consumed: true.
	anEvent currentTarget clickEvent: anEvent
]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> dragEndEvent: anEvent [

	anEvent consumed: true.
	anEvent currentTarget dispatchEvent: anEvent asClickCandidateEvent 

]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> dragEnterEvent: anEvent [

	anEvent consumed: true.
	anEvent currentTarget dispatchEvent: anEvent asMouseEnterEvent 
]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> dragEvent: anEvent [

	anEvent consumed: true.

]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> dragLeaveEvent: anEvent [

	anEvent consumed: true.
	anEvent currentTarget dispatchEvent: anEvent asMouseLeaveEvent 

]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> dragStartEvent: anEvent [

	anEvent consumed: true.

]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> dropEvent: anEvent [

	anEvent consumed: true.	
	anEvent currentTarget dispatchEvent: anEvent asClickCandidateEvent 

]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> eventsToHandle [

	^ { BlClickEvent. BlDoubleClickEvent. BlMouseDownEvent. BlMouseUpEvent. BlClickCandidateEvent. BlDragStartEvent. BlDragEvent. BlDragLeaveEvent. BlDragEnterEvent. BlDragEndEvent.  BlDropEvent }
]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> mouseDownEvent: anEvent [


	anEvent consumed: true
]

{ #category : #'api - accessing' }
ToButtonClickEventHandler >> mouseUpEvent: anEvent [

	"Because of the button has sub-elements, a Mouse up can a different target than the related mouse down but it can come from the button or from one of its children (if mouse has slided from the label to the icon as an example)"

	"mouse up must be consumed here so that BlClickCandidateEvent is created with the right BlMouseUpEvent"

	anEvent consumed: true
]
