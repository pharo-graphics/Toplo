Class {
	#name : #ToCheckNodeEventHandler,
	#superclass : #ToNodeEventHandler,
	#category : #'Toplo-Widget-List-node'
}

{ #category : #'event handling' }
ToCheckNodeEventHandler >> nodeHolderDeselectedEvent: anEvent [

	super nodeHolderDeselectedEvent: anEvent.
	anEvent currentTarget uncheck
]

{ #category : #'event handling' }
ToCheckNodeEventHandler >> nodeHolderSelectedEvent: anEvent [

	super nodeHolderSelectedEvent: anEvent.
	anEvent currentTarget check
]
