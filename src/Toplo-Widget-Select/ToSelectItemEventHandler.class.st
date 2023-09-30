Class {
	#name : #ToSelectItemEventHandler,
	#superclass : #ToMenuItemEventHandler,
	#category : #'Toplo-Widget-Select'
}

{ #category : #'mouse handlers' }
ToSelectItemEventHandler >> leftMouseUpEvent: anEvent [

	super leftMouseUpEvent: anEvent.
	privateTarget parentMenuWindow widget close
]
