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

	^ { ToListDoubleClickEvent. BlPrimaryClickEvent. BlPrimaryMouseDownEvent. ToListClickOnNodePreNotificationEvent. ToListClickOnNodeEvent  }
]

{ #category : #'events handling' }
ToListNodeSelectionEventHandler >> listClickOnNodeEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToListNodeSelectionEventHandler >> listClickOnNodePreNotificationEvent: anEvent [

	| node |
	node := anEvent currentTarget.
	node holder isSelectable ifFalse: [ anEvent deny ]
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

	| node preNotification eventToNotify |
	node := anEvent currentTarget.
	eventToNotify := ToListClickOnNodeEvent new
		                 sourceEvent: anEvent;
		                 yourself.
	preNotification := ToListClickOnNodePreNotificationEvent new
		                   sourceEvent: eventToNotify;
		                   yourself.
	node dispatchPreNotificationEvent: preNotification
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
