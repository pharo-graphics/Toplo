Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> clickableActionPerformedEvent: anEvent [
	" check event and current target "

	self closeWindowOnEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> closeWindowOnEvent: anEvent [
	" check event and current target "

	target isEnabled ifFalse: [ ^ self ].
	target closeOnMouseEvent ifFalse: [ ^ self ].
	" ask the window manager because it can manage the timestamp 
	and finally can decide to not close the menu window"
	target isInline ifTrue: [ ^ self ].
	target rootMenuDo: [ :rm |
		rm windowManager checkAutoCloseWindowOnMouseUp: anEvent ]
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
	"target closeOnMouseEvent ifFalse: [ ^ self ]."
	target closeSiblingMenuWindow.
	target isMenu ifFalse: [ ^ self ].
	target isOpened ifTrue: [ ^ self ].
	target isInline ifTrue: [ ^ self ].
	target popupEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseLeaveEvent: anEvent [
	" check event and current target "

	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ])
		ifTrue: [ ^ self ].
	target isEnabled ifFalse: [ ^ self ].
	target isTopMenu ifTrue: [ ^ self ].
	target closeOnMouseEvent ifFalse: [ ^ self ].
	target closeSiblingMenuWindow
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseUpEvent: anEvent [
	" check event and current target "

	self closeWindowOnEvent: anEvent
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
