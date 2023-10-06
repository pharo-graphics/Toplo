Class {
	#name : #ToMenuEventHandler,
	#superclass : #ToPopupWindowAssociateElementEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'mouse handlers' }
ToMenuEventHandler >> mouseDownOutsideEvent: anEvent [

	" only test on top menu "
	target isTopMenu ifFalse: [ ^ self ].
	(target includes: anEvent originalEvent target) ifTrue: [ ^ self ].

	" ok, the event is outside of the submenu chain"
	super mouseDownOutsideEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuEventHandler >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.
	" check event and current target "
	(anEvent anyButtonPressed and: [ anEvent currentTarget ~= target ])
		ifTrue: [ ^ self ].
	
	target isTopMenu ifTrue: [ ^ self ].
	self associateWindow popupEvent: anEvent.
	target parentMenuWindow openedSubmenuWindow: self associateWindow
]
