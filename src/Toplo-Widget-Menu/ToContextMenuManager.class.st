Class {
	#name : #ToContextMenuManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'window handling' }
ToContextMenuManager >> bottomUpCloseWindowRequestOnEvent: anEvent [ 

	self closeWindowNowOnEvent: anEvent
]

{ #category : #initialization }
ToContextMenuManager >> defaultPlacement [

	^ ToAnchoredPickedPlacement new
]

{ #category : #initialization }
ToContextMenuManager >> defaultWindowFactory [

	^ [ ToContextMenu ]
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
