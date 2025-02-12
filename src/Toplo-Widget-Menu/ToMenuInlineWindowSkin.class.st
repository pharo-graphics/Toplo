Class {
	#name : #ToMenuInlineWindowSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'event handling' }
ToMenuInlineWindowSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'menu-window-padding-V')
				 left: (e valueOfTokenNamed: #'menu-window-padding-H')
				 bottom: (e valueOfTokenNamed: #'menu-window-padding-V')
				 right: 2.0)."
		"e background: (Color veryLightGray alpha: 0.08)" ]
]
