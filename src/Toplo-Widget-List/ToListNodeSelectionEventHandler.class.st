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
	mode := listElement selectionMode.
	mode selectOnMouseDown ifTrue: [ ^ self ].
	self notifyClickOnNodeFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToListNodeSelectionEventHandler >> eventsToHandle [

	^ { ToListDoubleClickEvent. BlPrimaryClickEvent. BlPrimaryMouseDownEvent. ToListClickOnNodeEvent  }
]

{ #category : #'events handling' }
ToListNodeSelectionEventHandler >> listClickOnNodeEvent: anEvent [
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

	| node listElement preNotification eventToNotify |
	node := anEvent currentTarget.
	listElement := node holder listElement.
	eventToNotify := ToListClickOnNodeEvent new
		                 sourceEvent: anEvent;
		                 yourself.
	preNotification := ToListClickOnNodePreNotificationEvent new
		                   node: node;
		                   sourceEvent: eventToNotify;
		                   yourself.
	listElement dispatchEvent: preNotification.
	preNotification sourceEvent ifNil: [ ^ self ].
	node dispatchEvent: eventToNotify
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> primaryMouseDownEvent: anEvent [

	| node listElement mode |
	node := anEvent currentTarget.
	listElement := node holder listElement.
	mode := listElement selectionMode.
	mode allowRequestFocusOnMouseDown ifFalse: [ anEvent consume ].
	mode := listElement selectionMode.
	mode selectOnMouseDown ifFalse: [ ^ self ].
	self notifyClickOnNodeFromEvent: anEvent
]
