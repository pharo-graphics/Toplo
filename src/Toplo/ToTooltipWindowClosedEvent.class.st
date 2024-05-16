Class {
	#name : #ToTooltipWindowClosedEvent,
	#superclass : #ToAnchoredWindowClosedEvent,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #sending }
ToTooltipWindowClosedEvent >> sendTo: anObject [

	anObject tooltipWindowClosedEvent: self
]
