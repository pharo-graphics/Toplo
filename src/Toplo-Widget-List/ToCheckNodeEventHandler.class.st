Class {
	#name : #ToCheckNodeEventHandler,
	#superclass : #ToListNodeEventHandler,
	#category : 'Toplo-Widget-List-Node'
}

{ #category : #'event handling' }
ToCheckNodeEventHandler >> listNodeHolderDeselectedEvent: anEvent [

	super listNodeHolderDeselectedEvent: anEvent.
	anEvent currentTarget uncheck.
]

{ #category : #'event handling' }
ToCheckNodeEventHandler >> listNodeHolderSelectedEvent: anEvent [

	super listNodeHolderSelectedEvent: anEvent.
	anEvent currentTarget check.
]
