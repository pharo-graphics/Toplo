Class {
	#name : #ToMenuNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Item-List'
}

{ #category : #'event handling' }
ToMenuNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'menu-button-padding-H')
				 vertical: (e valueOfTokenNamed: #'menu-button-padding-V'))" ]
]
