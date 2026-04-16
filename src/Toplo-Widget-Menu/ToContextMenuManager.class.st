Class {
	#name : #ToContextMenuManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'windowClass'
	],
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #'window handling' }
ToContextMenuManager >> bottomUpCloseWindowRequestOnEvent: anEvent [ 

	self closeWindowIfMinimumDelayExceededOnEvent: anEvent
]

{ #category : #initialization }
ToContextMenuManager >> defaultPlacement [

	^ ToAnchoredPickedPlacement new
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

{ #category : #'api - hooks' }
ToContextMenuManager >> newOutsideEventFilter [

	^ super newOutsideEventFilter
		  elementToCheck: currentWindow;
		  yourself
]

{ #category : #'window handling' }
ToContextMenuManager >> windowClass [ 

	^ windowClass ifNil: [ windowClass := ToContextMenu ]
]

{ #category : #'window handling' }
ToContextMenuManager >> windowClass: aWindowClass [

	windowClass := aWindowClass
]
