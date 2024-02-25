Class {
	#name : #ToListNodeSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'events handling' }
ToListNodeSelectionEventHandler >> clickEvent: anEvent [


]

{ #category : #'api - accessing' }
ToListNodeSelectionEventHandler >> eventsToHandle [

	^ { ToListDoubleClickEvent. BlPrimaryClickEvent. BlPrimaryMouseDownEvent }
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> listDoubleClickEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> mouseDownEvent: anEvent [

		anEvent
		  ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		  secondary: [  ]
		  middle: [  ]
		  other: [  ]
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> primaryMouseDownEvent: anEvent [

	| target listElement mode |
	target := anEvent currentTarget.
	listElement := target holder listElement.
	mode := listElement selectionMode.
	mode allowRequestFocusOnMouseDown ifFalse: [ anEvent consumed: true ]
]
