Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'api - accessing' }
ToMenuItemEventHandler >> eventsToHandle [

	^  { BlMouseEnterEvent. BlMouseUpEvent }
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
	target popupEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseUpEvent: anEvent [

	" check event and current target "

	(anEvent currentTarget ~= target)
		ifTrue: [ ^ self ].
	target isEnabled ifFalse: [ ^ self ].
	target closeOnMouseEvent ifFalse: [ ^ self ].
	target rootMenu closeRequestFrom: target
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
