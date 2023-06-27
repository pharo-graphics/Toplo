Class {
	#name : #ToTooltipWindowDresser,
	#superclass : #ToDresser,
	#instVars : [
		'eventHandler'
	],
	#category : #'Toplo-Widget-Tooltip'
}

{ #category : #'api - install/uninstall  hook' }
ToTooltipWindowDresser >> newEventHandler [

	^ ToTooltipWindowEventHandler new
]

{ #category : #'api - install/uninstall  hook' }
ToTooltipWindowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
	anElement border: (BlBorder paint: (Color gray alpha: 0.4)).
	anElement background: (Color yellow alpha: 0.2).
	anElement padding: (BlInsets all: 4).
	anElement label margin: (BlInsets all: 4).
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
ToTooltipWindowDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: eventHandler.
	eventHandler := nil
]
