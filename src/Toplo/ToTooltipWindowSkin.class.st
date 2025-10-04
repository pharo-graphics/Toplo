Class {
	#name : #ToTooltipWindowSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'event handling' }
ToTooltipWindowSkin >> closedSkinEvent: anEvent [

	super closedSkinEvent: anEvent.
	anEvent elementDo: [ :e | | screenshot |
		screenshot := e screenshot.
		e anchorRoot addChild: screenshot.
		(e valueOfTokenNamed: #'window-closing-animation') value: screenshot ]
]

{ #category : #'event handling' }
ToTooltipWindowSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e
				addTokenNamed: #'font-size'
				withValue: (e valueOfTokenNamed: #'font-size-in-tooltip').
			e
				addTokenNamed: #'color-text'
				withValue: (e valueOfTokenNamed: #'text-foreground-in-tooltip').

			e padding: (BlInsets
					 horizontal: (e valueOfTokenNamed: #'padding-content-H')
					 vertical: (e valueOfTokenNamed: #'padding-content-V')).
			e effect: (e valueOfTokenNamed: #'effect-window') ]
]

{ #category : #'event handling' }
ToTooltipWindowSkin >> openedSkinEvent: anEvent [

	super openedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		(e valueOfTokenNamed: #'window-opening-animation') value: e ]
]
