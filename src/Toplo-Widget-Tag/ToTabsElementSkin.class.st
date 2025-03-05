Class {
	#name : #ToTabsElementSkin,
	#superclass : #ToItemBarElementSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabsElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color transparent.
		e border: BlBorder empty]
]
