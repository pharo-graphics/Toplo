Class {
	#name : #ToInlineMenuWindowSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToInlineMenuWindowSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: Color black.
		"e margin:
			(BlInsets left: (e valueOfTokenNamed: #'menu-item-start-alignment'))" ]
]

{ #category : #'event handling' }
ToInlineMenuWindowSkin >> openedSkinEvent: anEvent [

	super openedSkinEvent: anEvent.
	anEvent elementDo: [ :e | ]
]
