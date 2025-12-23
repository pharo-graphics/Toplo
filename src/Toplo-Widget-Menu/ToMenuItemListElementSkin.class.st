Class {
	#name : #ToMenuItemListElementSkin,
	#superclass : #ToItemListElementSkin,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'event handling' }
ToMenuItemListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: Color transparent.
		e background: Color transparent.
		e padding: BlInsets empty ]
]
