Class {
	#name : #ToTooltipWindowOpenedEvent,
	#superclass : #ToWindowOpenedEvent,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #sending }
ToTooltipWindowOpenedEvent >> sendTo: anObject [

	anObject tooltipWindowOpenedEvent: self
]
