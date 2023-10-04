Class {
	#name : #ToElementWithPopupWindowEventHandler,
	#superclass : #ToElementWithWindowEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToElementWithPopupWindowEventHandler >> elementPositionChangedEvent: anEvent [

	self window close
]

{ #category : #'event handling' }
ToElementWithPopupWindowEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	self window close
]

{ #category : #'api - accessing' }
ToElementWithPopupWindowEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementRemovedFromParentEvent. BlElementPositionChangedEvent . BlElementPositionInSpaceChangedEvent }
]

{ #category : #'mouse handlers' }
ToElementWithPopupWindowEventHandler >> mouseDownEvent: anEvent [

	super mouseDownEvent: anEvent.
	self window popupEvent: anEvent
]

{ #category : #'mouse handlers' }
ToElementWithPopupWindowEventHandler >> mouseUpEvent: anEvent [

	| delay |
	super mouseUpEvent: anEvent.
	self window parentDo: [ :p | " check a minimal delay between opening and closing.
		The mouse up can occur immediately after the window opening -> don't close the popup window.
		After a given delay between down and up, the popup window is closed "
		delay := anEvent timestamp - self window popupTimestamp.
		delay > self window autoCloseOnMouseUpDelay ifTrue: [
			self window close ] ].
	anEvent consumed: true
]

{ #category : #'mouse handlers' }
ToElementWithPopupWindowEventHandler >> mouseUpOutsideEvent: anEvent [

	" 
	if the original event target is the element with popup or
	if the original event target is the popup window then do nothing
	"
	anEvent originalEvent target ifNotNil: [ :originalTarget |
		(originalTarget hasParent: target) ifTrue: [ ^ self ].
		(originalTarget hasParent: window) ifTrue: [ ^ self ] ].
	
	" ok, mouseUp outside the element and outside of the popup window "
	anEvent consumed: true.
	window close
]
