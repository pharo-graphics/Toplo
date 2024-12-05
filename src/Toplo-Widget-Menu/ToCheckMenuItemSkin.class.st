Class {
	#name : #ToCheckMenuItemSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToCheckMenuItemSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"e icon innerImage border: (e valueOfTokenNamed: #'color-border-disabled').
		e icon border: (e valueOfTokenNamed: #'color-border-disabled').
		e indeterminateBar background: Color transparent" ]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"e icon border: (e valueOfTokenNamed: #'color-border')" ]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e button startAlignment: (e valueOfTokenNamed: #'menu-item-start-alignment') ].

	
]
