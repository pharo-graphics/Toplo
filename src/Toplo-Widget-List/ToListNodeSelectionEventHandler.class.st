Class {
	#name : #ToListNodeSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'events handling' }
ToListNodeSelectionEventHandler >> clickEvent: anEvent [

	| node listElement mode |
	node := anEvent currentTarget.
	listElement := node holder listElement.
	mode := listElement primarySelectionMode.
	mode selectOnMouseDown ifTrue: [ ^ self ].
	self notifyClickOnNodeFromEvent: anEvent.
	anEvent consume
]

{ #category : #'api - accessing' }
ToListNodeSelectionEventHandler >> eventsToHandle [

	^ {
		  ToListDoubleClickEvent.
		  BlPrimaryClickEvent.
		  BlPrimaryMouseDownEvent.
		  ToListClickOnNodeRequestEvent.
		  ToListClickOnNodeEvent }
]

{ #category : #'events handling' }
ToListNodeSelectionEventHandler >> listClickOnNodeEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> listClickOnNodeRequestEvent: aListClickOnNodeRequestEvent [

	| node |
	node := aListClickOnNodeRequestEvent currentTarget.
	node holder isSelectable ifFalse: [
		aListClickOnNodeRequestEvent deny ]
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
ToListNodeSelectionEventHandler >> notifyClickOnNodeFromEvent: anEvent [

	| node req |
	node := anEvent currentTarget.
	req := ToListClickOnNodeRequestEvent new
		       requestedAction: [
			       node dispatchEvent: (ToListClickOnNodeEvent new
						        sourceEvent: anEvent;
						        yourself) ];
		       yourself.
	node dispatchAuthorisationRequest: req
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> primaryMouseDownEvent: anEvent [

	| node listElement mode |
	node := anEvent currentTarget.
	listElement := node holder listElement.
	mode := listElement primarySelectionMode.
	mode allowRequestFocusOnMouseDown ifFalse: [ anEvent consume ].
	mode := listElement primarySelectionMode.
	mode selectOnMouseDown ifFalse: [ ^ self ].
	self notifyClickOnNodeFromEvent: anEvent
]
