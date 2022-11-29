Class {
	#name : #ToTooltipDresser,
	#superclass : #ToDresser,
	#instVars : [
		'eventHandler'
	],
	#category : #'Toplo-Widget-Tooltip'
}

{ #category : #'api - install/uninstall  hook' }
ToTooltipDresser >> newEventHandler [

	^ ToTooltipEventHandler new
]

{ #category : #'api - install/uninstall  hook' }
ToTooltipDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
	anElement border: (BlBorder paint: (Color gray alpha: 0.3)).
	anElement background: (Color yellow alpha: 0.1).
	anElement padding: (BlInsets all: 6).
	eventHandler := self newEventHandler.
	anElement addEventHandler: eventHandler.
	anElement constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent].
	anElement label constraintsDo: [ :c | 
		c linear vertical alignCenter.
		c linear horizontal alignCenter ].

]

{ #category : #'api - install/uninstall  hook' }
ToTooltipDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: eventHandler.
	eventHandler := nil
]
