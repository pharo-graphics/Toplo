Class {
	#name : 'ToTooltipWindowEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Core-Tooltip',
	#package : 'Toplo',
	#tag : 'Core-Tooltip'
}

{ #category : 'api - accessing' }
ToTooltipWindowEventHandler >> eventsToHandle [

	^ { BlMouseDownEvent }
]

{ #category : 'api - accessing' }
ToTooltipWindowEventHandler >> mouseDownEvent: anEvent [

	anEvent currentTarget close
]
