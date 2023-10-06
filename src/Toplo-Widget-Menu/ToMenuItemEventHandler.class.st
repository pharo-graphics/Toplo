Class {
	#name : #ToMenuItemEventHandler,
	#superclass : #ToPopupWindowAssociateElementEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseDownOutsideEvent: anEvent [

	| origEventTarget menu |
	
	target isTopMenu ifFalse: [ ^ self ].
	origEventTarget := anEvent originalEvent target.

self halt.
	menu := target .
	[ menu notNil ] whileTrue: [
		" If the original event target is one of the submenu child then do nothing"
		(origEventTarget hasInParentChain: menu associateWindow) ifTrue: [
			^ self ].
		menu := menu parentMenu].

	" ok, the event is outside of the submenu chain"
	super mouseDownOutsideEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ]) 
		ifTrue: [ ^ self ].
	target isTopMenu ifTrue: [ ^ self ].
	self associateWindow popupEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuItemEventHandler >> mouseLeaveEvent: anEvent [

	super mouseLeaveEvent: anEvent.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ]) 
		ifTrue: [ ^ self ].
	target isTopMenu ifTrue: [ ^ self ].
	"window close"
]
