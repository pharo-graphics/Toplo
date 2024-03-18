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

	| cursorElement bnds |
	cursorElement := anEvent currentTarget cursorElement.
	cursorElement textPosition traceCr.
	bnds := cursorElement bounds inSpace bounds.
	bnds height isZero ifTrue: [ ^ self ].
	windowPosition := bnds bottomRight.
	window popupEvent: anEvent
]

{ #category : #'api - accessing' }
ToAutocompleteEventHandler >> eventsToHandle [

	^ { AlbCursorElementMovedEvent }
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
