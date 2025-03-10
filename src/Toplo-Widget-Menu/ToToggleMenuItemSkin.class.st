Class {
	#name : #ToToggleMenuItemSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToToggleMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e startAlignment: (e valueOfTokenNamed: #'menu-item-start-alignment') ].

	
]
