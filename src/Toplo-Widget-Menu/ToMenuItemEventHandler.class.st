Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #ToSkinnableEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseEnterEvent: anEvent [

	| win |
	super mouseEnterEvent: anEvent.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ])
		ifTrue: [ ^ self ].

	target isTopMenu ifTrue: [ ^ self ].
	win := target associateWindow.
	target parentMenuWindow openedSubmenuWindow: win.
	win ifNotNil: [ win popupEvent: anEvent ].

]
