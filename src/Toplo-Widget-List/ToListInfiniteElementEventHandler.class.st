Class {
	#name : 'ToListInfiniteElementEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Widget-List-infinite',
	#package : 'Toplo-Widget-List',
	#tag : 'infinite'
}

{ #category : 'event handling' }
ToListInfiniteElementEventHandler >> blurEvent: aBlurEvent [

	| target |
	target := aBlurEvent currentTarget.
	target border: target defaultBlurBorder
]

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
		  BlElementScrolledEvent.
		  BlBlurEvent.
		  BlFocusEvent }
]

{ #category : 'event handling' }
ToListInfiniteElementEventHandler >> focusEvent: aFocusEvent [

	| target |
	target := aFocusEvent currentTarget.
	target border: target defaultFocusBorder
]

{ #category : 'event handling' }
ToListInfiniteElementEventHandler >> focusInEvent: aFocusEvent [

	| target |
	target := aFocusEvent currentTarget.
	target border: target defaultFocusBorder
]
