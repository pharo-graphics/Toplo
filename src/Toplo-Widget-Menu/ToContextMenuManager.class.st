Class {
	#name : #ToContextMenuManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Context menu'
}

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

	self closeWindow
]

{ #category : #initialization }
ToContextMenuManager >> initialize [

	super initialize.
	self useSecondaryMouseButton
]

{ #category : #'window handling' }
ToContextMenuManager >> onWindowOpened [

	super onWindowOpened.
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
