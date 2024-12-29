Class {
	#name : #ToSeparatorMenuItemSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToSeparatorMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding:
			(BlInsets vertical: (e valueOfTokenNamed: #'padding-content-VXS')) ]
]
