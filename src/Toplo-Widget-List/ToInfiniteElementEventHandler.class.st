Class {
	#name : #ToInfiniteElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'event handling' }
ToInfiniteElementEventHandler >> doubleClickEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target primarySelection dispatchStrongSelectionChangedTo: target 
]

{ #category : #'event handling' }
ToInfiniteElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget spaceDo: [ :sp | sp mouseProcessor handleLastMouseMove ]
]

{ #category : #'api - accessing' }
ToInfiniteElementEventHandler >> eventsToHandle [

	^ {
		  BlDoubleClickEvent.
		  BlElementScrolledEvent.
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent }
]

{ #category : #'event handling' }
ToInfiniteElementEventHandler >> infiniteElementAttachedEvent: anEvent [

	anEvent element dispatchEvent: (ToListNodeAttachementEvent new attached: true)
]

{ #category : #'event handling' }
ToInfiniteElementEventHandler >> infiniteElementDetachedEvent: anEvent [

	anEvent element dispatchEvent: (ToListNodeAttachementEvent new attached: false)
]
