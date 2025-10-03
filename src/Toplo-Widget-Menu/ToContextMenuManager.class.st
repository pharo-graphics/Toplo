Class {
	#name : #ToContextMenuManager,
	#superclass : #ToMenuWindowManager,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'window handling' }
ToContextMenuManager >> bottomUpCloseWindowRequestOnEvent: anEvent [ 
	" requestto actually manage the window closing "

	self closeWindowNowOnEvent: anEvent
]

{ #category : #initialization }
ToContextMenuManager >> defaultPlacement [

	^ ToAnchoredPickedPlacement new
]

{ #category : #accessing }
ToContextMenuManager >> defaultWindowClass [

	^ ToContextMenu 
]

{ #category : #'event handling' }
ToContextMenuManager >> elementPositionInSpaceChangedEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	self closeWindow
]

{ #category : #initialization }
ToContextMenuManager >> initialize [

	super initialize.
	self useSecondaryMouseButton
]

{ #category : #initialization }
ToContextMenuManager >> newOutsideEventFilter [

	^ super newOutsideEventFilter
		  elementToCheck: currentWindow;
		  yourself
]

{ #category : #'window handling' }
ToContextMenuManager >> onWindowOpenedOnEvent: anEvent [

	super onWindowOpenedOnEvent: anEvent.
	currentWindow itemBar requestFocus
]

{ #category : #accessing }
ToContextMenuManager >> windowRequestClass [

	^ ToContextMenuRequest 
]
