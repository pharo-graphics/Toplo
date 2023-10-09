Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #ToSkinnableEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ])
		ifTrue: [ ^ self ].

	target isTopMenu ifTrue: [ ^ self ].
	target closeSiblingMenuWindow.
	target isMenu ifFalse: [ ^ self ].
	target popupEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseUpEvent: anEvent [

	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ])
		ifTrue: [ ^ self ].
	super mouseUpEvent: anEvent.

	target isTopMenu ifTrue: [ ^ self ].
	target isSubmenu ifTrue: [ ^ self ].
	target rootMenu close 
]
