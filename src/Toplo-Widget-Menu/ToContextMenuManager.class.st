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

{ #category : #'event handling' }
ToContextMenuManager >> isPickedOutsideEvent: anEvent [
	" return true if the event is considered as a pick outside event "

	| target |
	target := anEvent target.
	"and outside of the popup windows ? "
	currentWindow withAllSubwindowsDo: [ :w |
		(target withAllParentsInclude: w) ifTrue: [ ^ false ] ].
	^ true
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
