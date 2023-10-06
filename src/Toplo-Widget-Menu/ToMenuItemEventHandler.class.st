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
	target isTopMenu ifTrue: [ ^ self ].
	window popupEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseLeaveEvent: anEvent [

	super mouseLeaveEvent: anEvent.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ]) 
		ifTrue: [ ^ self ].
	target isTopMenu ifTrue: [ ^ self ].
	window close
]
