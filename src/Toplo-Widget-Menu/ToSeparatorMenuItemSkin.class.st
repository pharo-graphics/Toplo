Class {
	#name : #ToSeparatorMenuItemSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToSeparatorMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e firstChild background: (e valueOfTokenNamed: #'color-border').
		e padding:
			(BlInsets vertical: (e valueOfTokenNamed: #'padding-content-VS')) ]
]
