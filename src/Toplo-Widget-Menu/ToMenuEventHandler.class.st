Class {
	#name : #ToMenuEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : 'Toplo-Widget-Menu-Basic'
}

{ #category : #'api - accessing' }
ToMenuEventHandler >> eventsToHandle [ 

	^ super eventsToHandle, { ToWindowClosedEvent }
]

{ #category : #'window handlers' }
ToMenuEventHandler >> windowClosedEvent: anEvent [

	anEvent currentTarget items do: [ :child |
		child removeFromParent ]
]
