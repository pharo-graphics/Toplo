Class {
	#name : #ToTooltipWindowEventHandler,
	#superclass : #ToSkinnableEventHandler,
	#category : 'Toplo-Core-Tooltip'
}

{ #category : #'api - accessing' }
ToTooltipWindowEventHandler >> mouseDownEvent: anEvent [

	super mouseDownEvent: anEvent.
	anEvent currentTarget close
]
