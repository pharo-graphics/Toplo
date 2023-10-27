Class {
	#name : 'ToMenuEventHandler',
	#superclass : 'ToElementWithPopupEventHandler',
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'api - accessing' }
ToMenuEventHandler >> eventsToHandle [ 

	^ super eventsToHandle, { ToWindowClosedEvent. ToWindowClosedEvent   }
]

{ #category : 'window handlers' }
ToMenuEventHandler >> windowClosedEvent: anEvent [

	anEvent currentTarget items do: [ :child |
		child removeFromParent.
		child removedFromMenu: anEvent currentTarget ]
]
