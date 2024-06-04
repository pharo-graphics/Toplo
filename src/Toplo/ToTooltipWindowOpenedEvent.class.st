Class {
	#name : #ToTooltipWindowOpenedEvent,
	#superclass : #ToAnchoredWindowOpenedEvent,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #sending }
ToTooltipWindowOpenedEvent >> sendTo: anObject [

	anObject tooltipWindowOpenedEvent: self
]
