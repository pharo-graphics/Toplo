Class {
	#name : #ToMouseEventListener,
	#superclass : #BlEventListener,
	#instVars : [
		'privateTarget'
	],
	#category : 'Toplo-Core'
}

{ #category : #'mouse handlers' }
ToMouseEventListener >> clickAvortedEvent: anEvent [

	super clickAvortedEvent: anEvent.
	(anEvent upEvent target ~= privateTarget and: [ (privateTarget findMouseEventTargetAt: anEvent upEvent position) isNil ])
		ifTrue: [ ^ self ].
	anEvent processor fireClickEventFrom: anEvent
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> clickEvent: anEvent [

	super clickEvent: anEvent.
	anEvent
		  ifPrimary: [ self leftClickEvent: anEvent ]
		  secondary: [ self rightClickEvent: anEvent ]
		  middle: [ self middleClickEvent: anEvent ]
		  other: [ self otherClickEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> doubleClickEvent: anEvent [

	super doubleClickEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> leftClickEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> leftMouseDownEvent: anEvent [


]

{ #category : #'mouse handlers' }
ToMouseEventListener >> leftMouseUpEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> middleClickEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> middleMouseDownEvent: anEvent [


]

{ #category : #'mouse handlers' }
ToMouseEventListener >> middleMouseUpEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> mouseDownEvent: anEvent [

	super mouseDownEvent: anEvent.
	anEvent
		  ifPrimary: [ self leftMouseDownEvent: anEvent ]
		  secondary: [ self rightMouseDownEvent: anEvent ]
		  middle: [ self middleMouseDownEvent: anEvent ]
		  other: [ self otherMouseDownEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> mouseLeaveEvent: anEvent [

	super mouseLeaveEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> mouseUpEvent: anEvent [

	super mouseUpEvent: anEvent.
	anEvent
		  ifPrimary: [ self leftMouseUpEvent: anEvent ]
		  secondary: [ self rightMouseUpEvent: anEvent ]
		  middle: [ self middleMouseUpEvent: anEvent ]
		  other: [ self otherMouseUpEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> otherClickEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> otherMouseDownEvent: anEvent [


]

{ #category : #'mouse handlers' }
ToMouseEventListener >> otherMouseUpEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> rightClickEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> rightMouseDownEvent: anEvent [


]

{ #category : #'mouse handlers' }
ToMouseEventListener >> rightMouseUpEvent: anEvent [

]

{ #category : #accessing }
ToMouseEventListener >> target: anElement [
	" the element which has myself as an event handler, must be not nil"
	privateTarget := anElement
]
