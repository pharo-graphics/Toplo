Class {
	#name : #ToMenuEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToMenuEventHandler >> windowClosedEvent: anEvent [
	
	anEvent windowManager = windowManager ifFalse: [ ^ self ].
	super windowClosedEvent: anEvent.
	anEvent currentTarget items do: [ :child |
		child removeFromParent ]
]
