Class {
	#name : #ToTooltipWindowClosedEvent,
	#superclass : #ToWindowClosedEvent,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #sending }
ToTooltipWindowClosedEvent >> sendTo: anObject [

	anObject tooltipWindowClosedEvent: self
]
