Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> clickableActionPerformedEvent: anEvent [
	" check event and current target "

	self onPickingEvent: anEvent
]

{ #category : #'api - accessing' }
ToMenuItemEventHandler >> eventsToHandle [

	^  { BlMouseEnterEvent. BlMouseLeaveEvent. BlMouseUpEvent. ToClickableActionPerformedEvent }
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseEnterEvent: anEvent [
	" check event and current target "

	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ])
		ifTrue: [ ^ self ].
	target isEnabled ifFalse: [ ^ self ].
	target isMenu ifFalse: [ ^ self ].

	target closeAllOtherPopupMenuWindows.
	target menuBar
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
	" check event and current target "

	target isMenu ifTrue: [
		target menuBarDo: [ :mb | mb switchAutoOpen ] ].
	self onPickingEvent: anEvent
]

{ #category : #'api - hooks' }
ToMenuItemEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	target := anElement
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> onPickingEvent: anEvent [
	" check event and current target "

	target isEnabled ifFalse: [ ^ self ].
	target closeOnPicking ifFalse: [ ^ self ].
	target isInline ifTrue: [ ^ self ].
	target rootMenuDo: [ :rm | 
		" ask the window manager because 
		it can manage the timestamp and finally can decide 
		to not close the menu window or to stop a delayed task"
		rm manager checkCloseWindowOnPickingEvent: anEvent ]
]

{ #category : #'api - hooks' }
ToMenuItemEventHandler >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	target := nil
]
