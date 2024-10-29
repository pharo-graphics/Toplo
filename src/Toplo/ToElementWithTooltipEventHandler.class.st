Class {
	#name : #ToElementWithTooltipEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'event handling' }
ToElementWithTooltipEventHandler >> tooltipWindowClosedEvent: anEvent [

	self windowClosedEvent: anEvent
]

{ #category : #'event handling' }
ToElementWithTooltipEventHandler >> tooltipWindowOpenedEvent: anEvent [

	self windowOpenedEvent: anEvent
]
