Class {
	#name : #ToListSecondarySelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'api - accessing' }
ToListSecondarySelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToListSecondarySelectionChangedEvent.
		  BlMouseMoveEvent }
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> listSecondarySelectionChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> mouseMoveEvent: anEvent [

	| target innerElement |
	target := anEvent currentTarget.
	target isEnabled ifFalse: [ ^ self ].
	innerElement := target innerElement.

	innerElement
		selectableNodeContainingGlobalPosition: anEvent position
		do: [ :nodeContainer | target secondarySelecter selectOnlyIndex: nodeContainer holder position ]
		ifNone: [ target secondarySelecter deselectAll ]
]
