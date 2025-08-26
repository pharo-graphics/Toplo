Class {
	#name : #ToContextMenuManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #initialization }
ToContextMenuManager >> defaultPlacement [

	^ ToAnchoredPickedPlacement new
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
ToContextMenuManager >> newPickOutsideFilter [

	^ super newPickOutsideFilter
		  shouldCheckElement: false;
		  yourself
]

{ #category : #'window handling' }
ToContextMenuManager >> onWindowOpened [

	super onWindowOpened.
	currentWindow itemBar requestFocus
]

{ #category : #accessing }
ToContextMenuManager >> popupWindowClass [

	^ ToContextMenu 
]

{ #category : #accessing }
ToContextMenuManager >> windowRequestClass [

	^ ToContextMenuRequest 
]
