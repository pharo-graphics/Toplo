Class {
	#name : 'ToCheckNodeEventHandler',
	#superclass : 'ToListNodeEventHandler',
	#category : 'Toplo-Widget-List-Node',
	#package : 'Toplo-Widget-List',
	#tag : 'Node'
}

{ #category : 'event handling' }
ToCheckNodeEventHandler >> nodeHolderDeselectedEvent: anEvent [

	super nodeHolderDeselectedEvent: anEvent.
	anEvent currentTarget uncheck
]

{ #category : 'event handling' }
ToCheckNodeEventHandler >> nodeHolderSelectedEvent: anEvent [

	super nodeHolderSelectedEvent: anEvent.
	anEvent currentTarget check
]
