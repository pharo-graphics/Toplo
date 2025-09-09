Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'action handling' }
ToMenuItemEventHandler >> actionPoolRunnedEvent: anEvent [

	" all actions are runned, now close the window "
	self closeWindowRequestOnEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> closeWindowRequestOnEvent: anEvent [
	" ask the window manager to actually manage the window closing "

	| target |
	target := anEvent currentTarget.
	target closeOnPicking ifFalse: [ ^ self ].
	target parentMenuDo: [ :m |
		m manager bottomUpCloseWindowRequestOnEvent: anEvent ]
]

{ #category : #'api - accessing' }
ToMenuItemEventHandler >> eventsToHandle [

	^  { BlMouseEnterEvent. BlMouseLeaveEvent. BlMouseUpEvent. ToActionPoolRunnedEvent }
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseEnterEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target isEnabled ifFalse: [ ^ self ].
	target closeAllOtherPopupMenuWindows.
	target menuPane
		ifNil: [ target isSubmenu ifFalse: [ ^ self ] ]
		ifNotNil: [ :mb | mb isAutoOpen ifFalse: [ ^ self ] ].

	target isOpened ifTrue: [ ^ self ].
	target openOnHovered ifFalse: [ ^ self ].
	target popupEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseLeaveEvent: anEvent [
	" check event and current target "

	| target |
	target := anEvent currentTarget.
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	target isEnabled ifFalse: [ ^ self ].
	(target firstInParentChainSatisfying: [ :e |
		 e isKindOf: ToMenuInlineWindowElement ]) ifNotNil: [ :w | ^ self ].

	target closeAllOtherPopupMenuWindows
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

	self closeWindowRequestOnEvent: anEvent
]
