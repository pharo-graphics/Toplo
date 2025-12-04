Class {
	#name : #ToMenuItemFiniteListElementSkin,
	#superclass : #ToItemFiniteListElementSkin,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'event handling' }
ToMenuItemFiniteListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: Color transparent.
		e background: Color transparent.
		e padding: BlInsets empty ]
]
