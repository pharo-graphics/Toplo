Class {
	#name : #ToMenuItemBarElementSkin,
	#superclass : #ToItemBarElementSkin,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'event handling' }
ToMenuItemBarElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'menu-pane-border-paint').
		e background: Color transparent.
		e padding: BlInsets empty ]
]
