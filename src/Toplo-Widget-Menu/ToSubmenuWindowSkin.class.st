Class {
	#name : #ToSubmenuWindowSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'event handling' }
ToSubmenuWindowSkin >> closedSkinEvent: anEvent [

	super closedSkinEvent: anEvent.
	anEvent elementDo: [ :e | | screenshot |
		screenshot := e screenshot.
		e anchorRoot addChild: screenshot.
		(e valueOfTokenNamed: #'window-closing-animation') value: screenshot ]
]

{ #category : #'event handling' }
ToSubmenuWindowSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'menu-window-padding-H')
				 vertical: (e valueOfTokenNamed: #'menu-window-padding-V')) ]
]
