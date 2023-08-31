Class {
	#name : #ToTooltipWindowEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'tooltipElement',
		'openTask'
	],
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'api - accessing' }
ToTooltipWindowEventHandler >> eventsToHandle [

	^ { 
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  BlMouseDownEvent }
]

{ #category : #'api - accessing' }
ToTooltipWindowEventHandler >> mouseDownEvent: anEvent [

	anEvent currentTarget close
]

{ #category : #'api - accessing' }
ToTooltipWindowEventHandler >> mouseEnterEvent: anEvent [


]

{ #category : #'api - accessing' }
ToTooltipWindowEventHandler >> mouseLeaveEvent: anEvent [


]
