Class {
	#name : #ToTooltipWindowSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'event handling' }
ToTooltipWindowSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
	e padding: (BlInsets
			 horizontal: (e valueOfTokenNamed: #'padding-content-H')
			 vertical: (e valueOfTokenNamed: #'padding-content-V')).
	e effect: (e valueOfTokenNamed: #'effect-window') ]
]

{ #category : #'event handling' }
ToTooltipWindowSkin >> openedSkinEvent: anEvent [

	super openedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		(e valueOfTokenNamed: #'animation-window-opening') value: e ]
]
