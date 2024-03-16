Class {
	#name : #ToAutocompleteEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'windowManager',
		'window',
		'windowPosition'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'event handling' }
ToAutocompleteEventHandler >> cursorElementMovedEvent: anEvent [

	windowPosition := anEvent currentTarget bounds inSpace bounds bottomRight.
	windowPosition traceCr.
	window popupEvent: anEvent
]

{ #category : #'event handling' }
ToAutocompleteEventHandler >> cursorElementPositionChangedEvent: anEvent [

	windowPosition := anEvent currentTarget bounds inSpace bounds bottomRight.
	window popupEvent: anEvent
]

{ #category : #'api - accessing' }
ToAutocompleteEventHandler >> eventsToHandle [

	^ {"AlbCursorElementMovedEvent."
		  AlbTextInsertedEvent.
		  AlbTextDeletedEvent }
]

{ #category : #'api - hooks' }
ToAutocompleteEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	windowManager := ToAnchoredWindowManager new.
	windowManager onInstalledIn: anElement.
	windowManager builder: [ :anchWin :element |
		anchWin addChild: (BlElement new
				 size: 50 @ 70;
				 background: Color red;
				 yourself) ].
	anElement cursorElement addEventHandlerOn: BlElementPositionInSpaceChangedEvent do: [ :event | self cursorElementPositionChangedEvent: event ].
	anElement cursorElement addEventHandlerOn: BlElementAddedToParentEvent do: [ :event | self cursorElementPositionChangedEvent: event ].
	windowManager positionHook: [ :theWindow :theElement :event |
		theElement enqueueTask: (BlTaskAction new action: [
				 theWindow position: self windowPosition]) ].
	window := windowManager newWindowEvent: nil
]

{ #category : #'event handling' }
ToAutocompleteEventHandler >> textDeletedEvent: aTextDeletedEvent [

	"window popupEvent: aTextDeletedEvent"
]

{ #category : #'event handling' }
ToAutocompleteEventHandler >> textInsertedEvent: aTextEditedEvent [

	"window popupEvent: aTextEditedEvent"
]

{ #category : #accessing }
ToAutocompleteEventHandler >> windowPosition [ 

	^ windowPosition 
]
