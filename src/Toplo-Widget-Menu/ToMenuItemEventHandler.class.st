Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> checkCloseOnPickingEvent: anEvent [
	" check event and current target "

	target isEnabled ifFalse: [ ^ self ].
	target closeOnPicking ifFalse: [ ^ self ].
	" ask the window manager because it can manage the timestamp 
	and finally can decide to not close the menu window"
	(target isInInlineWindow or: [ target isInline ]) ifTrue: [ ^ self ].
	target rootMenuDo: [ :rm |
		rm manager checkAutoCloseWindowOnMouseUp: anEvent ]
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> clickableActionPerformedEvent: anEvent [
	" check event and current target "

	self checkCloseOnPickingEvent: anEvent
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
	target isTopMenu ifTrue: [ ^ self ].
	target closeSiblingMenuWindow.
	target isMenu ifFalse: [ ^ self ].
	target isOpened ifTrue: [ ^ self ].
	target openOnHovered ifFalse: [  ^ self ].
	target popupEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseLeaveEvent: anEvent [
	" check event and current target "

	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ])
		ifTrue: [ ^ self ].
	target isEnabled ifFalse: [ ^ self ].
	target isTopMenu ifTrue: [ ^ self ].
	target closeOnPicking ifFalse: [ ^ self ].
	target closeSiblingMenuWindow
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseUpEvent: anEvent [
	" check event and current target "

	self checkCloseOnPickingEvent: anEvent
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
