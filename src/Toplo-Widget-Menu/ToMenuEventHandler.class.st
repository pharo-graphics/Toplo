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
