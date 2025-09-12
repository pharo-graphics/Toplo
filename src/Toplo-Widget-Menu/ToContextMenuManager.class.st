Class {
	#name : #ToContextMenuManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'window handling' }
ToContextMenuManager >> bottomUpCloseWindowRequestOnEvent: anEvent [ 
	" requestto actually manage the window closing "

	self checkCloseWindowOnEvent: anEvent
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

{ #category : #'window handling' }
ToContextMenuManager >> onWindowOpenedOnEvent: anEvent [

	super onWindowOpenedOnEvent: anEvent.
	currentWindow itemBar requestFocus
]

{ #category : #initialization }
ToContextMenuManager >> pickOutsideFilterClass [ 

	^ ToContextMenuMouseUpOutsideEventFilter
]

{ #category : #accessing }
ToContextMenuManager >> windowRequestClass [

	^ ToContextMenuRequest 
]
