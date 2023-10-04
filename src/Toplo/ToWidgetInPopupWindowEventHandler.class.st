Class {
	#name : #ToWidgetInPopupWindowEventHandler,
	#superclass : #ToWidgetInWindowEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToWidgetInPopupWindowEventHandler >> elementPositionChangedEvent: anEvent [

	self window close
]

{ #category : #'event handling' }
ToWidgetInPopupWindowEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	self window close
]

{ #category : #'event handling' }
ToWidgetInPopupWindowEventHandler >> elementRemovedFromParentEvent: anEvent [

	self window close
]

{ #category : #'api - accessing' }
ToWidgetInPopupWindowEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementRemovedFromParentEvent. BlElementPositionChangedEvent . BlElementPositionInSpaceChangedEvent }
]

{ #category : #'event handling' }
ToWidgetInPopupWindowEventHandler >> mouseDownEvent: anEvent [

	super mouseDownEvent: anEvent.
	self window popupEvent: anEvent
]

{ #category : #'event handling' }
ToWidgetInPopupWindowEventHandler >> mouseUpEvent: anEvent [ 

	| delay |
	super mouseUpEvent: anEvent.
	" check a minimal delay between opening and closing.
	The mouse up can occur immediately after the window opening -> don't close the popup window.
	After a given delay between down and up, the popup window is closed
	"

	delay := anEvent timestamp - self window popupTimestamp.

	delay > self window autoCloseOnMouseUpDelay
		ifTrue: [ self window close ].
	anEvent consumed: true
]
