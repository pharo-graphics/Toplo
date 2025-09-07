Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'api - accessing' }
ToMenuItemEventHandler >> eventsToHandle [

	^  { BlMouseEnterEvent. BlMouseLeaveEvent. BlMouseUpEvent. ToLinkActionRunnedEvent }
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> linkActionRunnedEvent: anEvent [
	" check event and current target "

	"self onPickingEvent: anEvent"
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseEnterEvent: anEvent [
	" check event and current target "

	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ])
		ifTrue: [ ^ self ].
	target isEnabled ifFalse: [ ^ self ].
	"target isMenu ifFalse: [ ^ self ]."

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

	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ])
		ifTrue: [ ^ self ].
	target isEnabled ifFalse: [ ^ self ].
	(target firstInParentChainSatisfying: [ :e |
		 e isKindOf: ToMenuInlineWindowElement ]) ifNotNil: [ :w | ^ self ].

	target closeAllOtherPopupMenuWindows 
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseUpEvent: anEvent [

	" ask the window manager to actually manage the event "
	target parentMenuDo: [ :m | m manager onMouseUpOnItemEvent: anEvent ]
]

{ #category : #'api - hooks' }
ToMenuItemEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	target := anElement
]

{ #category : #'api - hooks' }
ToMenuItemEventHandler >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	target := nil
]
