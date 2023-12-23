Class {
	#name : 'ToMenuEventHandler',
	#superclass : 'ToElementWithPopupEventHandler',
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'window handlers' }
ToMenuEventHandler >> windowClosedEvent: anEvent [
	
	super windowClosedEvent: anEvent.
	anEvent currentTarget items do: [ :child |
		child removeFromParent ]
]
