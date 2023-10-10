Class {
	#name : #ToMenuEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'api - accessing' }
ToMenuEventHandler >> eventsToHandle [ 

	^ super eventsToHandle, { ToWindowClosedEvent. ToWindowClosedEvent   }
]

{ #category : #'mouse handlers' }
ToMenuEventHandler >> mouseDownOutsideEvent: anEvent [

	" only test on top menu "
	target isTopMenu ifFalse: [ ^ self ].
	" is the target an item in the menu chain"
	(target includes: anEvent originalEvent target) ifTrue: [ ^ self ].

	" ok, the event is outside of the submenu chain"
	super mouseDownOutsideEvent: anEvent
]

{ #category : #'window handlers' }
ToMenuEventHandler >> windowClosedEvent: anEvent [

	anEvent currentTarget items do: [ :child |
		child removeFromParent.
		child removedFromMenu: anEvent currentTarget ]
]
