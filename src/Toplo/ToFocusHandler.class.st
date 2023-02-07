Class {
	#name : #ToFocusHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core'
}

{ #category : #'event handling' }
ToFocusHandler >> blurEvent: anEvent [

	anEvent currentTarget onLostFocus
]

{ #category : #'event handling' }
ToFocusHandler >> clickEvent: anEvent [

	anEvent currentTarget requestFocus 
]

{ #category : #'api - accessing' }
ToFocusHandler >> eventsToHandle [

	^ {  BlClickEvent.
		  BlFocusEvent.
		  BlBlurEvent }
]

{ #category : #'event handling' }
ToFocusHandler >> focusEvent: anEvent [

	anEvent currentTarget onGotFocus
]
