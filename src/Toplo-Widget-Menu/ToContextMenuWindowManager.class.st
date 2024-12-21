Class {
	#name : #ToContextMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #initializing }
ToContextMenuWindowManager >> defaultPlacement [

	^ ToPickedPlacement new
]

{ #category : #'event handling' }
ToContextMenuWindowManager >> elementPositionInSpaceChangedEvent: anEvent [

	self currentWindowDo: [ :cw | cw close ] 
]

{ #category : #initialization }
ToContextMenuWindowManager >> initialize [

	super initialize.
	self useSecondaryMouseButton
]

{ #category : #'window handling' }
ToContextMenuWindowManager >> newPickOutsideFilter [

	^ super newPickOutsideFilter
		  shouldCheckElement: false;
		  yourself
]

{ #category : #'window handling' }
ToContextMenuWindowManager >> onOpened [

	super onOpened.
	currentWindow itemList requestFocus.
]

{ #category : #accessing }
ToContextMenuWindowManager >> windowClass [

	^ ToContextMenu 
]

{ #category : #accessing }
ToContextMenuWindowManager >> windowRequestClass [

	^ ToContextMenuRequest 
]
