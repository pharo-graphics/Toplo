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
	listElement isEnabled ifFalse: [ ^ self ].
	mode := listElement primarySelectionMode.
	mode selectOnPressed ifTrue: [ ^ self ].
	self notifyClickOnNodeFromEvent: anEvent.
	"anEvent consume"
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> doubleClickEvent: anEvent [
]

{ #category : #'api - accessing' }
ToListNodeSelectionEventHandler >> eventsToHandle [

	^ {
		  BlDoubleClickEvent.
		  BlPrimaryClickEvent.
		  BlPrimaryMouseDownEvent.
		  ToListClickOnNodeRequestEvent.
		  ToListClickOnNodeEvent }
]

{ #category : #'events handling' }
ToListNodeSelectionEventHandler >> listClickOnNodeEvent: anEvent [
]

{ #category : #'events handling' }
ToListNodeSelectionEventHandler >> listClickOnNodeRequestEvent: aListClickOnNodeRequestEvent [

	| node |
	node := aListClickOnNodeRequestEvent currentTarget.
	node holder isSelectable ifFalse: [
		aListClickOnNodeRequestEvent deny ]
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> mouseDownEvent: anEvent [

	| node listElement |
	node := anEvent currentTarget.
	listElement := node holder listElement.
	listElement isEnabled ifFalse: [ ^ self ].

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
	node isAttachedToSceneGraph ifFalse: [ ^ self ].
	req := ToListClickOnNodeRequestEvent new
		       requestedAction: [
			       node dispatchEvent: (ToListClickOnNodeEvent new
						        timestamp: node space time now;
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
	mode selectOnPressed ifFalse: [ ^ self ].
	self notifyClickOnNodeFromEvent: anEvent
]
