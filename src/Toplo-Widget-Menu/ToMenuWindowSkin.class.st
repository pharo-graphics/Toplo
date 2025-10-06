Class {
	#name : #ToMenuWindowSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'event handling' }
ToMenuWindowSkin >> closedSkinEvent: anEvent [

	super closedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| screenshot |
			screenshot := e screenshot.
			e anchorRoot addChild: screenshot.
			(e valueOfTokenNamed: #'window-closing-animation') value:
				screenshot ]
]

{ #category : #'event handling' }
ToMenuWindowSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'menu-window-padding-H')
				 vertical: (e valueOfTokenNamed: #'menu-window-padding-V')).
		e effect: (e valueOfTokenNamed: #'effect-window') ]
]

{ #category : #'event handling' }
ToMenuWindowSkin >> openedSkinEvent: anEvent [

	super openedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		(e valueOfTokenNamed: #'window-opening-animation') value: e ]
]
