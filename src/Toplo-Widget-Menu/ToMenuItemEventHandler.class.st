Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'action handling' }
ToMenuItemEventHandler >> actionPoolRunnedEvent: anEvent [

	" all actions are runned, now close the window "
	self bottomUpCloseWindowRequestOnEvent: anEvent
]

{ #category : #'action handling' }
ToMenuItemEventHandler >> bottomUpCloseWindowRequestOnEvent: anEvent [
	" ask the window manager to actually manage the window closing "

	| target |
	target := anEvent currentTarget.
	target closeOnPicking ifFalse: [ ^ self ].
	target menuPaneDo: [ :mp | mp cancelAutoOpen ].
	target parentMenuDo: [ :m |
		m manager bottomUpCloseWindowRequestOnEvent: anEvent ]
]

{ #category : #'api - accessing' }
ToMenuItemEventHandler >> eventsToHandle [

	^  { BlMouseEnterEvent. BlMouseUpEvent. ToActionPoolRunnedEvent }
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseEnterEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target isEnabled ifFalse: [ ^ self ].
	target closeAllSiblingMenuWindows.
	target menuPane
		ifNil: [ target isSubmenu ifFalse: [ ^ self ] ]
		ifNotNil: [ :mb | mb isAutoOpen ifFalse: [ ^ self ] ].
	target isOpened ifTrue: [ ^ self ].
	target openOnHovered ifFalse: [ ^ self ].
	target popupEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseUpEvent: anEvent [
	" ask the window manager to actually manage the event "
	| target |
	target := anEvent currentTarget.
	target isEnabled ifFalse: [ ^ self ].

	" if the item has one or several linkActions, do nothing here. 
	The window can't be closed before all actions are runned.
	The window closing will occur on ToActionPoolRunnedEvent receiving
	( see actionPoolRunnedEvent: )"
	target actionPoolDo: [ :la | ^ self ].

	self bottomUpCloseWindowRequestOnEvent: anEvent
]
