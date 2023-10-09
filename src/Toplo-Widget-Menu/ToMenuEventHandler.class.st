Class {
	#name : #ToMenuEventHandler,
	#superclass : #ToPopupWindowAssociateElementEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'api - accessing' }
ToMenuEventHandler >> eventsToHandle [ 

	^ super eventsToHandle, { ToWindowClosedEvent  }
]

{ #category : #'mouse handlers' }
ToMenuEventHandler >> mouseDownOutsideEvent: anEvent [

	" only test on top menu "
	target isTopMenu ifFalse: [ ^ self ].
	(target includes: anEvent originalEvent target) ifTrue: [ ^ self ].

	" ok, the event is outside of the submenu chain"
	super mouseDownOutsideEvent: anEvent
]

{ #category : #'api - accessing' }
ToMenuEventHandler >> windowClosedEvent: anEvent [

	anEvent currentTarget items do: [ :child |
		child removeFromParent.
		child removedFromMenu: anEvent currentTarget ]
]
