Class {
	#name : #ToCheckMenuItemSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToCheckMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e button startAlignment: (e valueOfTokenNamed: #'menu-item-start-alignment') ].

	
]
