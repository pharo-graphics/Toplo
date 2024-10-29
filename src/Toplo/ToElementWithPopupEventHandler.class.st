Class {
	#name : #ToElementWithPopupEventHandler,
	#superclass : #ToAnchorEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToElementWithPopupEventHandler >> contextMenuRequest: anEvent [
]

{ #category : #'api - accessing' }
ToElementWithPopupEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseUpEvent.
		  BlMouseDownEvent.
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  windowManager autoClosePickOutsideEventClass }
]

{ #category : #'event handling' }
ToElementWithPopupEventHandler >> mouseDownEvent: anEvent [

	windowManager mouseDownInElementEvent: anEvent
]

{ #category : #'event handling' }
ToElementWithPopupEventHandler >> mouseDownOutsideEvent: anEvent [

	self pickOutsideEvent: anEvent
]

{ #category : #'event handling' }
ToElementWithPopupEventHandler >> mouseEnterEvent: anEvent [

	windowManager mouseEnterInElementEvent: anEvent
]

{ #category : #'event handling' }
ToElementWithPopupEventHandler >> mouseLeaveEvent: anEvent [

	windowManager mouseLeaveInElementEvent: anEvent
]

{ #category : #'event handling' }
ToElementWithPopupEventHandler >> mouseUpEvent: anEvent [

	windowManager mouseUpInElementEvent: anEvent
]

{ #category : #'event handling' }
ToElementWithPopupEventHandler >> mouseUpOutsideEvent: anEvent [

	self pickOutsideEvent: anEvent
]

{ #category : #'api - hooks' }
ToElementWithPopupEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	target := anElement.
	target allowMousePickOutsideEvent.
]

{ #category : #'api - hooks' }
ToElementWithPopupEventHandler >> onUninstalledIn: anElement [

	target := nil.
	super onUninstalledIn: anElement.

]

{ #category : #'event handling' }
ToElementWithPopupEventHandler >> pickOutsideEvent: anEvent [

	windowManager pickOutsideElementEvent: anEvent
]

{ #category : #'event handling' }
ToElementWithPopupEventHandler >> popupWindowClosedEvent: anEvent [

	self windowClosedEvent: anEvent
]

{ #category : #'event handling' }
ToElementWithPopupEventHandler >> popupWindowOpenedEvent: anEvent [

	self windowOpenedEvent: anEvent
]

{ #category : #accessing }
ToElementWithPopupEventHandler >> target [

	^ target
]

{ #category : #'api - accessing' }
ToElementWithPopupEventHandler >> windowEventsToHandle [

	^ {
		  ToAnchoredWindowOpenRequest.
		  ToPopupWindowClosedEvent.
		  ToPopupWindowOpenedEvent }
]
