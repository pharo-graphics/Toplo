Class {
	#name : #ToMenuItemListElementSkin,
	#superclass : #ToItemBarElementSkin,
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #'event handling' }
ToMenuItemListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: BlInsets empty ]
]
