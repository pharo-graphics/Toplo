Class {
	#name : 'ToTooltipWindowEventHandler',
	#superclass : 'ToSkinnableEventHandler',
	#category : 'Toplo-Core-Tooltip',
	#package : 'Toplo',
	#tag : 'Core-Tooltip'
}

{ #category : 'api - accessing' }
ToTooltipWindowEventHandler >> mouseDownEvent: anEvent [

	super mouseDownEvent: anEvent.
	anEvent currentTarget close
]
