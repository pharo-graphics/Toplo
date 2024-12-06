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
				 horizontal: (e valueOfTokenNamed: #'padding-content-HXS')
				 vertical: (e valueOfTokenNamed: #'padding-content-VXS'))" ]
]
