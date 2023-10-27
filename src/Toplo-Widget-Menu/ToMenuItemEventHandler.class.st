Class {
	#name : 'ToMenuItemEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'target'
	],
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'api - accessing' }
ToMenuItemEventHandler >> eventsToHandle [

	^  { BlMouseEnterEvent. BlMouseUpEvent }
]

{ #category : 'mouse handlers' }
ToMenuItemEventHandler >> mouseEnterEvent: anEvent [

	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ])
		ifTrue: [ ^ self ].

	target isTopMenu ifTrue: [ ^ self ].
	target closeSiblingMenuWindow.
	target isMenu ifFalse: [ ^ self ].
	target popupEvent: anEvent
]

{ #category : 'mouse handlers' }
ToMenuItemEventHandler >> mouseUpEvent: anEvent [

	" check event and current target "
	(anEvent currentTarget ~= target)
		ifTrue: [ ^ self ].

	target closeOnMouseEvent ifFalse: [ ^ self ].
	target rootMenu closeWindow
]

{ #category : 'api - hooks' }
ToMenuItemEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	target := anElement
]

{ #category : 'api - hooks' }
ToMenuItemEventHandler >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	target := nil
]
