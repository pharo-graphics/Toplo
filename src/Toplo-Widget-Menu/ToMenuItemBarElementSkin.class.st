Class {
	#name : #ToMenuItemBarElementSkin,
	#superclass : #ToItemBarElementSkin,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'event handling' }
ToMenuItemBarElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: Color transparent.
		e background: Color transparent.
		e padding: BlInsets empty ]
]
