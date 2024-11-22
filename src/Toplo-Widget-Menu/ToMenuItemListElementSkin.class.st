Class {
	#name : #ToMenuItemListElementSkin,
	#superclass : #ToBasicListElementSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToMenuItemListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty.
		e padding: BlInsets empty ]
]
