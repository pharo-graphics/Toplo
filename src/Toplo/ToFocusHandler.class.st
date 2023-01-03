Class {
	#name : #ToFocusHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core'
}

{ #category : #'event handling' }
ToFocusHandler >> blurEvent: anEvent [

	anEvent currentTarget onLostFocus
]

{ #category : #'api - accessing' }
ToFocusHandler >> eventsToHandle [

	^ { 
		  BlFocusEvent.
		  BlBlurEvent }
]

{ #category : #'event handling' }
ToFocusHandler >> focusEvent: anEvent [

	anEvent currentTarget onGotFocus
]
