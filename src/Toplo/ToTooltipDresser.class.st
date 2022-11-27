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
	eventHandler := self newEventHandler.
	anElement addEventHandler: eventHandler.
	anElement constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent].
	anElement label constraintsDo: [ :c | 
		c linear vertical alignCenter.
		c linear horizontal alignCenter ].
	anElement background: (Color yellow alpha: 0.4).
]

{ #category : #'api - install/uninstall  hook' }
ToTooltipDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: eventHandler.
	eventHandler := nil
]
