Class {
	#name : #ToMenuNodeSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Item-List'
}

{ #category : #'event handling' }
ToMenuNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"e background: BlBackground transparent."
		"e border: Color black."
		"e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'menu-node-padding-H')
				 vertical: (e valueOfTokenNamed: #'menu-node-padding-V'))" ]
]
