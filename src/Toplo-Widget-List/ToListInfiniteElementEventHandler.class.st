Class {
	#name : 'ToListInfiniteElementEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Widget-List-infinite',
	#package : 'Toplo-Widget-List',
	#tag : 'infinite'
}

{ #category : 'event handling' }
ToListInfiniteElementEventHandler >> doubleClickEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target primarySelection dispatchStrongSelectionChangedTo: target 
]

{ #category : 'event handling' }
ToListInfiniteElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget spaceDo: [ :sp | sp mouseProcessor handleLastMouseMove ]
]

{ #category : 'api - accessing' }
ToListInfiniteElementEventHandler >> eventsToHandle [

	^ {
		  BlDoubleClickEvent.
		  BlElementScrolledEvent }
]
