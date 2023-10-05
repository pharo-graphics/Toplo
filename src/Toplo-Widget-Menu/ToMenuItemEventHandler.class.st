Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #ToElementWithPopupWindowEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ]) 
		ifTrue: [ ^ self ].
	" ok, I can close other item submenu window"
	window popupEvent: anEvent
]
