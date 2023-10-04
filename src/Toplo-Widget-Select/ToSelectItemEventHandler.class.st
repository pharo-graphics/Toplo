Class {
	#name : #ToSelectItemEventHandler,
	#superclass : #ToMenuItemEventHandlerDep,
	#category : #'Toplo-Widget-Select'
}

{ #category : #'mouse handlers' }
ToSelectItemEventHandler >> leftMouseUpEvent: anEvent [

	super leftMouseUpEvent: anEvent.
	target parentMenuWindow widget close
]
